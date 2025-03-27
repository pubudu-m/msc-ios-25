//
//  ContentView.swift
//  WeatherApp-FT
//
//  Created by Pubudu Mihiranga on 2025-03-20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherVM = WeatherViewModel()
    @StateObject private var locationSvc = LocationService()
    
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
                    let lat = locationSvc.lastKnownLocation?.latitude ?? 44.34
                    let lon = locationSvc.lastKnownLocation?.longitude ?? 10.99
                    await weatherVM.fetchWeatther(latitude: lat, longitude: lon)
                }
            }
            
            Text("\(locationSvc.lastKnownLocation?.latitude ?? 0.0)")
            Text("\(locationSvc.lastKnownLocation?.longitude ?? 0.0)")
            
            Button("Location") {
                locationSvc.checkLocationAuthorization()
            }
        }
        .padding()
        .task {
            locationSvc.checkLocationAuthorization()
            let lat = locationSvc.lastKnownLocation?.latitude ?? 44.34
            let lon = locationSvc.lastKnownLocation?.longitude ?? 10.99
            await weatherVM.fetchWeatther(latitude: lat, longitude: lon)
        }
    }
}

#Preview {
    ContentView()
}
