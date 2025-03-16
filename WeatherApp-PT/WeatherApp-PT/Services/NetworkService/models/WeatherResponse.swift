//
//  WeatherResponse.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-16.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String
    let main: Temperature
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temperature: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
