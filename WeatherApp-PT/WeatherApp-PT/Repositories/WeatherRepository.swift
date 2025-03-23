//
//  WeatherRepository.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-16.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse
}

class WeatherRepository: WeatherRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let coreDataService: CoreDataServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        coreDataService: CoreDataServiceProtocol = CoreDataService.shared
    ) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
    
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        // load the data from cache
        if let cachedWeather = coreDataService.fetchWeather(latitute: latitude, longitude: longitude),
            let timestamp = cachedWeather.timestamp,
           Date().timeIntervalSince(timestamp) < 1800 {
            guard let response = cachedWeather.toWeatherResponse() else {
                throw NetworkServiceError.decodingFailed
            }
            print("dev test: loaded from cache")
            return response
        }
        
        // load the data via API
        let request = WeatherRequest.current(latitude: latitude, longitude: longitude)
        let weatherResponse: WeatherResponse = try await networkService.request(endpoint: request)
        
        // save it to cache
        coreDataService.cacheWeather(latitute: latitude, longitude: longitude, data: weatherResponse)
        
        print("dev test: loaded via API")
        
        return weatherResponse
    }
}
