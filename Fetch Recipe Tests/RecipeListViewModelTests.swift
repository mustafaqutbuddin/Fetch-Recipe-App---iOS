//
//  RecipeListViewModelTests.swift
//  Fetch Recipe Tests
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import XCTest
@testable import Fetch_Recipe_Test


class RecipeListViewModelTests: XCTestCase {
    var recipeListViewModel: RecipeListViewModel!
    
    override func setUp() {
        super.setUp()
        recipeListViewModel = RecipeListViewModel(remoteServiceHandler: MockRecipeService())
    }
    
    override func tearDown() {
        recipeListViewModel = nil
        super.tearDown()
    }
    
    func testGroupRecipesByCuisine_WhenRecipesExist() {
        let recipes = [
            Recipe(id: "1", cuisine: "British", name: "Apple Pie", imageURLLarge: "", imageURLSmall: ""),
            Recipe(id: "2", cuisine: "Malaysian", name: "Nasi Lemak", imageURLLarge: "", imageURLSmall: ""),
            Recipe(id: "3", cuisine: "British", name: "Shepherd's Pie", imageURLLarge: "", imageURLSmall: "")
        ]
        
        let groupedRecipes = recipeListViewModel.groupCuisines(by: recipes)
        
        XCTAssertEqual(groupedRecipes.count, 2, "Expected 2 different cuisines")
        XCTAssertEqual(groupedRecipes[0].value.count, 2, "Expected 2 British recipes")
        XCTAssertEqual(groupedRecipes[1].value.count, 1, "Expected 1 Malaysian recipe")
    }
    
    func testGroupRecipesByCuisine_sortingOrder_WhenRecipesExist() {
        let recipes = [
            Recipe(id: "1", cuisine: "British", name: "Apple Pie", imageURLLarge: "", imageURLSmall: ""),
            Recipe(id: "2", cuisine: "Malaysian", name: "Nasi Lemak", imageURLLarge: "", imageURLSmall: ""),
            Recipe(id: "3", cuisine: "American", name: "Burger", imageURLLarge: "", imageURLSmall: ""),
            Recipe(id: "4", cuisine: "British", name: "Shepherd's Pie", imageURLLarge: "", imageURLSmall: "")
        ]
        
        let groupedRecipes = recipeListViewModel.groupCuisines(by: recipes)
        
        XCTAssertEqual(groupedRecipes[0].key, "American", "Expected first group to be American")
        XCTAssertEqual(groupedRecipes[1].key, "British", "Expected second group to be British")
        XCTAssertEqual(groupedRecipes[2].key, "Malaysian", "Expected third group to be Malaysian")
    }
    
    func testGroupRecipesByCuisine_WhenNoRecipesExist() {
        let emptyRecipes: [Recipe] = []
        
        let groupedRecipes = recipeListViewModel.groupCuisines(by: emptyRecipes)
        
        XCTAssertTrue(groupedRecipes.isEmpty, "Expected no groups when no recipes exist")
    }
    
    // MARK: - Test Cases for API State Logic
    
    func testGetRecipes_ApiState_Success() async {
        let recipes = [
            Recipe(id: "1", cuisine: "British", name: "Apple Pie", imageURLLarge: "", imageURLSmall: "")
        ]
        
        let mockService = MockRecipeService(mockRecipes: recipes)
        recipeListViewModel = RecipeListViewModel(remoteServiceHandler: mockService)
        
        await recipeListViewModel.getRecipes()
        
        await MainActor.run {
            XCTAssertEqual(recipeListViewModel.apiState, .success(recipes), "Expected success state with recipes")
            XCTAssertEqual(recipeListViewModel.groupCuisines(by: recipes).count, 1, "Expected recipes to be grouped correctly")
        }
    }
    
    func testGetRecipes_ApiState_Empty() async {
        let mockService = MockRecipeService(mockRecipes: [])
        recipeListViewModel = RecipeListViewModel(remoteServiceHandler: mockService)
        
        await recipeListViewModel.getRecipes()
        
        await MainActor.run {
            XCTAssertEqual(recipeListViewModel.apiState, .empty, "Expected empty state when no recipes are returned")
            XCTAssertTrue(recipeListViewModel.groupCuisines(by: []).isEmpty, "Expected no recipes grouped")
        }
    }
    
    func testGetRecipes_ApiState_Failure() async {
        let mockService = MockRecipeServiceError()
        recipeListViewModel = RecipeListViewModel(remoteServiceHandler: mockService)
        
        await recipeListViewModel.getRecipes()
        
        await MainActor.run {
            XCTAssertEqual(recipeListViewModel.apiState, .failure("The operation couldn’t be completed. (NSURLErrorDomain error -1011.)"), "Expected failure state with error message")
        }
    }
    
}
