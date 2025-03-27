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
    private let coreDataService: CoreDataService
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        coreDataService: CoreDataService = CoreDataService.shared
    ) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
    
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        // Fetching via Cache
        if let cachedData = coreDataService.fetchData(latitude: latitude, longitude: longitude), let timestamp = cachedData.timestamp, Date().timeIntervalSince(timestamp) < 1800 {
            guard let decodedData = cachedData.toWeatherResponse() else {
                throw NetworkServiceError.decodingFailed
            }
            return decodedData
        }
        
        // Fetching via API
        let request = WeatherRequest.current(latitude: latitude, longitude: longitude)
        let weatherResponse: WeatherResponse = try await networkService.request(endpoint: request)
        
        // Save to Cache
        coreDataService.saveData(latitude: latitude, longitude: longitude, data: weatherResponse)
        
        return weatherResponse
    }
}
