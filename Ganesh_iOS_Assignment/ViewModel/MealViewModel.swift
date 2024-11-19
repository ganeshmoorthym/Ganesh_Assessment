//
//  MealViewModel.swift
//  AFKLMAssignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import Combine
import Foundation
import SwiftData
import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String = ""
    var dataManager: DataManager?
    var mealsContext: ModelContext?
   
    init(mealsContext: ModelContext?) {
        dataManager = DataManager(mealsContext: mealsContext)
    }
    
    @MainActor
    func fetchMealsList() async {
        do {
            let arrayMeal = try dataManager?.fetchDataFromDB()
            if arrayMeal?.count ?? 0 > 0 {
                self.meals = arrayMeal?.compactMap { convertToMealModel(model: $0) } ?? []
                return
            }
            try await fetchMealsListFromAPI()
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    func convertToMealModel(model: MealsData) -> Meal {
        Meal(model: model)
    }

    func fetchMealsListFromAPI() async throws {
        do {
            guard let url = urlEndPoint.fetchMeals.url else {
                return 
            }
            let mealsAPI = APIClient(networkService: APIManager())
            let result = try await mealsAPI.fetchMealsList(url: url)
            switch result {
            case .success(let meals):
                try await MainActor.run {
                    self.meals = meals
                    try dataManager?.saveMealData(meals: meals)
                }
            case .failure(let error):
                throw error
            }
        } catch {
            throw error
        }
    }
}
 
