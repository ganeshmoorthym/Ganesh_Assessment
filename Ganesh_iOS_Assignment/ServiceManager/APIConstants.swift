//
//  APIConstants.swift
//  AFKLMAssignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import Foundation

struct URLKeys {
    static let mealsBaseURL = "https://www.themealdb.com/api/json/v1/1/search.php?f=a"
    
}

struct JSONFileNames {
    static let mealsMockFilename = "MockMealsData"
}

struct FileTypes {
    static let json = "json"
}

public enum urlEndPoint {
    case fetchMeals
    var url: URL? {
        switch self {
        case .fetchMeals:
            return URL(string: URLKeys.mealsBaseURL)
        }
    }
}

enum errorTypes: Error {
    case emptyUrl
    case urlRequestError
    case jsonDecoderError
}
