//
//  RecipeListViewModel.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    @MainActor @Published var apiState: ApiState<[Recipe]> = .idle
    let remoteServiceHandler: RecipeService
    
    init(remoteServiceHandler: RecipeService = RemoteRecipeService()) {
        self.remoteServiceHandler = remoteServiceHandler
    }
    
    @MainActor
    func getRecipes() async {
        do {
            let recipes = try await remoteServiceHandler.getRecipes()
            if recipes.isEmpty {
                apiState = .empty
            } else {
                apiState = .success(recipes)
            }
        } catch {
            print(error.localizedDescription)
            apiState = .failure(error.localizedDescription)
        }
    }
    
    
    func groupCuisines(by recipes: [Recipe]) -> [(key: String, value: [Recipe])] {
        let groupedRecipesByCusine = Dictionary(grouping: recipes, by: \.cuisine)
        // sort them alphabetically as per cuisine
        return groupedRecipesByCusine.sorted { $0.key < $1.key }
    }
}



