//
//  WeatherRequest.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-16.
//

import Foundation

enum WeatherRequest {
    case current(latitude: Double, longitude: Double)
    case airPollution(latitude: Double, longitude: Double)
}

extension WeatherRequest: NetworkRequest {
    var scheme: NetworkScheme {
        switch self {
        case .current:
            return .https
        case .airPollution:
            return .http
        }
    }
    
    var baseURL: String {
        return APIConstants.baseURLString
    }
    
    var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .airPollution:
            return "/data/2.5/air_pollution"
        }
    }
    
    var parameteres: [URLQueryItem] {
        switch self {
        case .current(let latitude, let longitude):
            let params = [
                URLQueryItem(name: "lat", value: "\(latitude)"),
                URLQueryItem(name: "lon", value: "\(longitude)"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: APIConstants.apiKey)
            ]
            
            return params
        case .airPollution(let latitude, let longitude):
            let params = [
                URLQueryItem(name: "lat", value: "\(latitude)"),
                URLQueryItem(name: "lon", value: "\(longitude)"),
                URLQueryItem(name: "appid", value: APIConstants.apiKey)
            ]
            
            return params
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .current:
            return .get
        case .airPollution:
            return .get
        }
    }
}
