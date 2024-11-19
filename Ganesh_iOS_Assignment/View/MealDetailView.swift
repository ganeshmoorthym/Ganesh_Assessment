//
//  MealDetailView.swift
//  AFKLMAssignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(meal.name)
                    .font(.largeTitle)
                Text(meal.instructions)
                    .font(.subheadline)
            }
            .padding()
        }
        Spacer()
    }
}
