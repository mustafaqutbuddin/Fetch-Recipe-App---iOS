//
//  ContentView.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var recipeListViewModel = RecipeListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch recipeListViewModel.apiState {
                case .idle:
                    ProgressView()
                        .controlSize(.large)
                case .success(let recipes):
                    displayRecipeList(for: recipes)
                case .empty:
                    displayEmptyView
                case .failure(_):
                    displayFailureView
                }
            }
            .task {
                await recipeListViewModel.getRecipes()
            }
            .navigationTitle("Recipes")
        }
    }
}

private extension RecipeListView {
    @ViewBuilder func displayRecipeList(for recipes: [Recipe]) -> some View {
        List {
            ForEach(recipeListViewModel.groupCuisines(by: recipes), id: \.key) { cuisine, recipes in
                Section(header: Text(cuisine)) {
                    HorizontalScroll(data: recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                            .padding(.horizontal, 8)
                    }
                }
                .listSectionSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .refreshable {
            await recipeListViewModel.getRecipes()
        }
    }
    
    var displayEmptyView: some View {
        ApiStateOverlayView(
            title: "No data to display",
            systemImage: "wifi.slash",
            descriptionText: "Check your internet connection or try again later.",
            buttonTitle: "Retry") {
                Task {
                    await recipeListViewModel.getRecipes()
                }
            }
    }
    
    var displayFailureView: some View {
        ApiStateOverlayView(
            title: "There was a problem!",
            systemImage: "bolt",
            descriptionText: "Sorry for the inconvenience caused, We are trying our best to fix the issue. Please try again later."
        )
    }
}

#Preview {
    RecipeListView()
}
