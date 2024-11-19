//
//  ContentView.swift
//  Ganesh_iOS_Assignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                HStack {
                    Text("Meals List")
                }
                .frame(height: 56)
                MealListView(mealsContext: modelContext)
                Spacer()
            }
        }
    }
}
