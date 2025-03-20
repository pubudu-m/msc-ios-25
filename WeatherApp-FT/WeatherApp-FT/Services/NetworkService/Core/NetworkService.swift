//
//  NetworkService.swift
//  WeatherApp-FT
//
//  Created by Pubudu Mihiranga on 2025-03-20.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(endpoint: NetworkRequest) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    func request<T: Codable>(endpoint: any NetworkRequest) async throws -> T {
        let components = endpoint.buildURLComponents()
        guard let url = components.url else {
            throw NetworkServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkServiceError.invalidResponse
        }
        
        let statusCode = httpResponse.statusCode
        switch statusCode {
        case 200...299:
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw NetworkServiceError.decodingFailed
            }
        case 400...499:
            throw NetworkServiceError.clientError(statusCode)
        case 500...599:
            throw NetworkServiceError.serverError(statusCode)
        default:
            throw NetworkServiceError.unexpectedError
        }
    }
}
