//
//  Ganesh_iOS_AssignmentTests.swift
//  Ganesh_iOS_AssignmentTests
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import XCTest
import SwiftData
@testable import Ganesh_iOS_Assignment

final class Ganesh_iOS_AssignmentTests: XCTestCase {

    var apiClient: APIClient!
    
    override func setUpWithError() throws {
        let mockAPIService = MockAPIManager()
        apiClient = APIClient(networkService: mockAPIService)
    }

    override func tearDownWithError() throws {
    }
    
    func testFetchAPIDataFromLocalBundleJson() async throws {
        guard let url = urlEndPoint.fetchMeals.url else {
            throw errorTypes.emptyUrl
        }

        let result = try await apiClient.fetchMealsList(url: url)
        switch result {
        case .success(let meals):
            let meal = meals.first
            XCTAssert(meals.count == 4)
            XCTAssert(meal?.name == "Apple Frangipan Tart")
        case .failure(let error):
            throw error
        }
    }
    
    //fetch data from api
    @MainActor func testFetchDataAPI() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: MealsData.self, configurations: config)
        let viewModel = MealViewModel(mealsContext: container.mainContext)
        try await viewModel.fetchMealsListFromAPI()
        XCTAssertFalse(viewModel.meals.isEmpty == true, "Model is Not empty")
        XCTAssertFalse(viewModel.meals.count == 0, "Count Not matching")
        XCTAssertFalse(viewModel.meals.first?.name == "", "Name Not Match")
    }
    
    //fetch data from db
    @MainActor func testFetchDataFromDB() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: MealsData.self, configurations: config)
        let viewModel = MealViewModel(mealsContext: container.mainContext)
        await viewModel.fetchMealsList()
        XCTAssertFalse(viewModel.meals.isEmpty == true)
        XCTAssertFalse(viewModel.meals.count == 0)
        XCTAssertFalse(viewModel.meals.first?.name == "")
    }
}
