//
//  ContentView.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherVM = WeatherViewModel(repository: WeatherRepository(networkService: NetworkService()))
    
    var body: some View {
        VStack {
            if weatherVM.isLoading {
                ProgressView("Loading weather data..")
            } else if let weatherData = weatherVM.weatherData {
                Text(weatherData.name)
                    .font(.largeTitle)
                
                Text("\(Int(weatherData.main.temp))°C")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                
                Text(weatherData.weather.first?.description ?? "")
            } else if let error = weatherVM.errorMessage {
                Text(error)
            } else {
                Text("No weather data available")
            }
            
            Button("Refresh") {
                Task {
                    await weatherVM.fetchWeather(latitude: 44.34, longitude: 10.99)
                }
            }
        }
        .padding()
        .task {
            await weatherVM.fetchWeather(latitude: 44.34, longitude: 10.99)
        }
    }
}

#Preview {
    ContentView()
}
