//
//  MockAPIManager.swift
//  Ganesh_iOS_Assignment
//
//  Created by Ganesh Moorthy on 19/11/24.
//

import Foundation

class MockAPIManager: APIService {
    
    /// Meals API Start
    func fecthMealsList(url: URL) async throws -> Result<[Meal],Error> {
        do {
            //data from local bundle json file
            guard let bundleUrl = Bundle.main.url(forResource: JSONFileNames.mealsMockFilename, withExtension: FileTypes.json) ?? nil else { return .failure(errorTypes.jsonDecoderError) }
            let data = try Data(contentsOf: bundleUrl)
            return try handleMealsResponse(data: data)
        } catch {
            return .failure(error)
        }
    }
    
    func handleMealsResponse(data: Data) throws -> Result<[Meal],Error> {
        do {
            let mealsModel = try JSONDecoder().decode(MealsResponse.self, from: data)
            return .success(mealsModel.meals ?? [])
        } catch {
            return .failure(error)
        }
    }
    /// Meals API End
}
