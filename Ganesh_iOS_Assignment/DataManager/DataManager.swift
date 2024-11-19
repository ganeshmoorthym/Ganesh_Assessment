//
//  MealsDataManager.swift
//  AFKLMAssignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import Foundation
import SwiftData
import SwiftUI

class DataManager {
    var mealsContext: ModelContext?
    
    init(mealsContext: ModelContext?) {
        self.mealsContext = mealsContext
    }
    
    /// Meals DB Start
    //Get contect from db
    func fetchDataFromDB() throws -> [MealsData]?  {
        let descriptor = FetchDescriptor<MealsData>()
        do {
            return try mealsContext?.fetch(descriptor)
        } catch {
            throw error
        }
    }
    
    //Save data to db
    func saveMealData(meals: [Meal]) throws {
        for meal in meals {
            let mealModel = MealsData(model: meal)
            mealsContext?.insert(mealModel)
        }
        do {
            try mealsContext?.save()
        } catch {
            throw error
        }
    }
    /// Meals DB End
}
