//
//  MockApiDataHandler.swift
//  Fetch Recipe Tests
//
//  Created by Mustafa Qutbuddin on 2024-10-07.
//

import Foundation
@testable import Fetch_Recipe_Test

class MockApiDataHandler: ApiDataHandlerProtocol {
    var data: Data?
    var error: Error?
    
    func fetchRemoteData(url: URL) async throws -> Data {
        if let error = error {
            throw error
        }
        return data ?? Data()
    }
}
