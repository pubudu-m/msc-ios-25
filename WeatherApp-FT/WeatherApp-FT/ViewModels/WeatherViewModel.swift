//
//  WeatherViewModel.swift
//  WeatherApp-FT
//
//  Created by Pubudu Mihiranga on 2025-03-20.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol = WeatherRepository()) {
        self.repository = repository
    }
    
    func fetchWeatther(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil
        
        do {
            weatherData = try await repository.getWeather(latitude: latitude, longitude: longitude)
            isLoading = false
        } catch {
            errorMessage = "Something went wrong! \(error.localizedDescription)"
            isLoading = false
        }
    }
}
