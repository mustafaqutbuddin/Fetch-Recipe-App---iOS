//
//  MockApiResponseHandler.swift
//  Fetch Recipe Tests
//
//  Created by Mustafa Qutbuddin on 2024-10-07.
//

import Foundation
@testable import Fetch_Recipe_Test

class MockApiResponseHandler: ApiResponseHandlerProtocol {
    var decodedResponse: Codable?
    var error: Error?
    
    func handleResponse<T>(forType type: T.Type, data: Data) throws -> T where T : Decodable {
        if let error = error {
            throw error
        }
        
        guard let decodedResponse = decodedResponse as? T else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Mocked decoding failure"))
        }
        return decodedResponse
    }
}
