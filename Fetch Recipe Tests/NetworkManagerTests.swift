//
//  NetworkManagerTests.swift
//  Fetch Recipe Tests
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import XCTest
@testable import Fetch_Recipe_Test

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var mockApiDataHandler: MockApiDataHandler!
    var mockApiResponseHandler: MockApiResponseHandler!
    
    override func setUp() {
        super.setUp()
        
        mockApiDataHandler = MockApiDataHandler()
        mockApiResponseHandler = MockApiResponseHandler()
        networkManager = NetworkManager(apiDataHandler: mockApiDataHandler, apiResponseHandler: mockApiResponseHandler)
    }
    
    override func tearDown() {
        networkManager = nil
        mockApiDataHandler = nil
        mockApiResponseHandler = nil
        super.tearDown()
    }
    
    func testFetchRemoteRequest_Success() async throws {
        let jsonString = """
            {
                "recipes": [{"id": "123", "cuisine": "Malaysian", "name": "Apam Balik", "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg", "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",}]
            }
            """
        
        mockApiDataHandler.data = jsonString.data(using: .utf8)
        
        let expectedRecipe = Recipe(id: "123",
                                    cuisine: "Malaysian",
                                    name: "Apam Balik",
                                    imageURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                                    imageURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        
        mockApiResponseHandler.decodedResponse = RecipeResponse(recipes: [expectedRecipe])
        
        let result = try await getMockApiData()
        XCTAssertEqual(result.recipes.count, 1)
        XCTAssertEqual(result.recipes.first?.name, "Apam Balik")
    }
    
    func testFetchRemoteRequest_Failure() async throws {
        mockApiDataHandler.error = URLError(.badServerResponse)
        
        do {
            _ = try await getMockApiData()
            XCTFail("Expected to throw error but did not")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.cannotDecodeRawData))
        }
    }
    
    func testFetchRemoteRequest_Failure_MalformedData() async throws {
        mockApiDataHandler.error = URLError(.badServerResponse)
        
        do {
            _ = try await getMockApiData()
            XCTFail("Expected to throw error but did not")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, URLError.cannotDecodeRawData)
        }
    }
    
    func testFetchRemoteRequest_Success_EmptyData() async throws {
        let jsonString = """
           {
               "recipes": []
           }
           """
        
        mockApiDataHandler.data = jsonString.data(using: .utf8)
        mockApiResponseHandler.decodedResponse = RecipeResponse(recipes: [])
        
        let result = try await getMockApiData()
        XCTAssertTrue(result.recipes.isEmpty)
    }
    
}

// MARK: - Helpers
private extension NetworkManagerTests {
    func getMockApiData() async throws -> RecipeResponse {
        return try await networkManager.fetchRemoteRequest(from: URL(string: "https://example.com")!, type: RecipeResponse.self)
    }
}
