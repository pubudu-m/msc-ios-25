//
//  WeatherViewModel.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-16.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil
        
        do {
            weatherData = try await repository.getWeather(latitude: latitude, longitude: longitude)
            isLoading = false
        } catch {
            errorMessage = "Something Went Wrong!\n \(error.localizedDescription)"
            isLoading = false
        }
    }
}
