//
//  RecipeService.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import Foundation

protocol RecipeService {
    func getRecipes() async throws -> [Recipe]
}

struct RemoteRecipeService: RecipeService {
    func getRecipes() async throws -> [Recipe] {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw URLError(.badURL)
        }
        return try await NetworkManager().fetchRemoteRequest(from: url, type: RecipeResponse.self).recipes
    }
}
