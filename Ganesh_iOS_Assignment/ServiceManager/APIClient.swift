//
//  APIClient.swift
//  Ganesh_iOS_Assignment
//
//  Created by Ganesh Moorthy on 19/11/24.
//

import Foundation

class APIClient {
    private let networkService: APIService
    
    init(networkService: APIService) {
        self.networkService = networkService
    }
    
    /// Meals API
    func fetchMealsList(url: URL) async throws -> Result<[Meal],Error> {
        return try await self.networkService.fecthMealsList(url: url)
    }
}

