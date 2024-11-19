//
//  APIManager.swift
//  Ganesh_iOS_Assignment
//
//  Created by Ganesh Moorthy on 19/11/24.
//

import Foundation

protocol APIService {
    /// Meals
    func fecthMealsList(url: URL) async throws -> Result<[Meal],Error>
}

class APIManager: APIService {
    
    /// Meals API Start
    func fecthMealsList(url: URL) async throws -> Result<[Meal],Error> {
        do {
            let urlRequest = URLRequest(url: url)
            let (data,urlResponse) = try await URLSession.shared.data(for: urlRequest)
            return try handleMealsResponse(data: data, urlResponse: urlResponse)
        } catch {
            return .failure(error)
        }
    }
    
    func handleMealsResponse(data: Data, urlResponse: URLResponse) throws -> Result<[Meal],Error> {
        do {
            let mealsModel = try JSONDecoder().decode(MealsResponse.self, from: data)
            guard let urlRespone = urlResponse as? HTTPURLResponse,
                urlRespone.statusCode >= 200 && urlRespone.statusCode < 300 else {
                return .failure(errorTypes.urlRequestError)
            }
            return .success(mealsModel.meals ?? [])
        } catch {
            return .failure(error)
        }
    }
    /// Meals API End
}
