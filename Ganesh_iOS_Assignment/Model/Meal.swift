//
//  Meal.swift
//  AFKLMAssignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import Foundation

struct MealsResponse: Decodable {
    var meals: [Meal]?
}

struct Meal: Decodable, Identifiable {
    let id: String
    let name: String
    let instructions: String
    let thumbnail: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case category = "strCategory"
    }

    var thumbnailURL: URL? {
        guard let thumbnail = URL(string: thumbnail) else { return nil }
        return thumbnail
    }
}

extension Meal {
    init(model: MealsData) {
        self.id = model.id
        self.name = model.name
        self.instructions = model.instructions
        self.thumbnail = model.thumbnail
        self.category = model.category
    }
}
