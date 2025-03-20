//
//  WeatherRepository.swift
//  WeatherApp-FT
//
//  Created by Pubudu Mihiranga on 2025-03-20.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse
}

class WeatherRepository: WeatherRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        let request = WeatherRequest.current(latitude: latitude, longitude: longitude)
        let weatherResponse: WeatherResponse = try await networkService.request(endpoint: request)
        return weatherResponse
    }
}
