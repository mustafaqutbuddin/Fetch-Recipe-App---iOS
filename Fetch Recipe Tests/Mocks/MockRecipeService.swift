//
//  MockRecipeService.swift
//  Fetch Recipe Tests
//
//  Created by Mustafa Qutbuddin on 2024-10-07.
//

import Foundation
@testable import Fetch_Recipe_Test

class MockRecipeService: RecipeService {
    var mockRecipes: [Recipe]
    
    init(mockRecipes: [Recipe] = []) {
        self.mockRecipes = mockRecipes
    }
    
    func getRecipes() async throws -> [Recipe] {
        return mockRecipes
    }
}

class MockRecipeServiceError: RecipeService {
    func getRecipes() async throws -> [Recipe] {
        throw URLError(.badServerResponse)
    }
}
