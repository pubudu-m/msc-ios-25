//
//  ContentView.swift
//  WeatherApp-FT
//
//  Created by Pubudu Mihiranga on 2025-03-20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        VStack {
            if weatherVM.isLoading {
                ProgressView("Loading..")
            } else if let weatherData = weatherVM.weatherData {
                Text(weatherData.name)
                    .font(.largeTitle)
                
                Text("\(Int(weatherData.main.temp))°C")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                
                Text(weatherData.weather.first?.description ?? "")
            } else if let errorMessage = weatherVM.errorMessage {
                Text(errorMessage)
            } else {
                Text("No weather data available")
            }
            
            Button("Refresh") {
                Task {
                    await weatherVM.fetchWeatther(latitude: 44.34, longitude: 10.99)
                }
            }
        }
        .padding()
        .task {
            await weatherVM.fetchWeatther(latitude: 44.34, longitude: 10.99)
        }
    }
}

#Preview {
    ContentView()
}
