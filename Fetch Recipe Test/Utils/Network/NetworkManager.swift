//
//  NetworkManager.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import Foundation

enum ApiState<T: Equatable>: Equatable {
    case idle
    case success(T)
    case empty
    case failure(String)
}

protocol ApiDataHandlerProtocol {
    func fetchRemoteData(url: URL) async throws -> Data
}

class ApiDataHandler: ApiDataHandlerProtocol {
    func fetchRemoteData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw URLError(.badURL)
        }
    }
}

protocol ApiResponseHandlerProtocol {
    func handleResponse<T:Codable>(forType type: T.Type, data: Data) throws -> T
}

class ApiResponseHandler: ApiResponseHandlerProtocol {
    func handleResponse<T:Codable>(forType type: T.Type, data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type.self, from: data)
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}

class NetworkManager {
    let apiDataHandler: ApiDataHandlerProtocol
    let apiResponseHandler: ApiResponseHandlerProtocol
    
    init(apiDataHandler: ApiDataHandlerProtocol = ApiDataHandler(), apiResponseHandler: ApiResponseHandlerProtocol = ApiResponseHandler()) {
        self.apiDataHandler = apiDataHandler
        self.apiResponseHandler = apiResponseHandler
    }
    
    func fetchRemoteRequest<T:Codable>(from url: URL, type: T.Type) async throws -> T {
        do {
            let data = try await apiDataHandler.fetchRemoteData(url: url)
            return try apiResponseHandler.handleResponse(forType: type, data: data)
        } catch {
            throw URLError(.cannotDecodeRawData)
        }
    }
}
