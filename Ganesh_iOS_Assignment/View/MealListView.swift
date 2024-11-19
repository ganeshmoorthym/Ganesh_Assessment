//
//  MealListView.swift
//  AFKLMAssignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import Foundation
import SwiftData
import SwiftUI

struct MealListView: View {
    @StateObject var viewModel: MealViewModel

    init(mealsContext: ModelContext?) {
        _viewModel = StateObject(wrappedValue: MealViewModel(mealsContext: mealsContext))
    }

    var body: some View {
        Group {
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Text(viewModel.errorMessage)
                        .font(.caption)
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.meals) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal)) {
                                MealListItemView(meal: meal)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                .background(Color.gray.opacity(0.1))
            }
        }
        .task {
            await viewModel.fetchMealsList()
        }
    }
}

struct MealListItemView: View {
    var meal: Meal
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            //Meals image view
            loadMealsImage(mealsImageUrl: meal.thumbnailURL)
                .cornerRadius(8)
            //Name and Category
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                if !meal.category.isEmpty {
                    Text("Category: \(meal.category)")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(8)
    }
    //Meals image view
    private func loadMealsImage(mealsImageUrl: URL?) -> some View {
        AsyncImage(url: mealsImageUrl, content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        }) {
            ProgressView()
        }
        .frame(width: 100, height: 100)
    }
}
