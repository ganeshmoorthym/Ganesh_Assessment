//
//  MealsData.swift
//  AFKLMAssignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import Foundation
import SwiftData

@Model
class MealsData {
    let id: String
    let name: String
    let instructions: String
    let thumbnail: String
    let category: String
    
    init(id: String, name: String = "", instructions: String = "", thumbnail: String = "", category: String = "") {
        self.id = id
        self.name = name
        self.instructions = instructions
        self.thumbnail = thumbnail
        self.category = category
    }
    
    init(model: Meal) {
        self.id = model.id
        self.name = model.name
        self.instructions = model.instructions
        self.thumbnail = model.thumbnail
        self.category = model.category
    }
}
