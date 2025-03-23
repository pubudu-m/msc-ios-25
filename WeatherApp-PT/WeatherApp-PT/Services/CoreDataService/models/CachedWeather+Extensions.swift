//
//  CachedWeather+Extensions.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-23.
//

import Foundation

extension CachedWeather {
    func toWeatherResponse() -> WeatherResponse? {
        guard let data = self.data else {
            return nil
        }
        
        let converetedData = try? JSONDecoder().decode(WeatherResponse.self, from: data)
        return converetedData
    }
}
