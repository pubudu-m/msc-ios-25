//
//  WeatherEntity+Extensions.swift
//  WeatherApp-FT
//
//  Created by Pubudu Mihiranga on 2025-03-27.
//

import Foundation

extension WeatherEntity {
    func toWeatherResponse() -> WeatherResponse? {
        guard let data = self.data else { return nil }
        return try? JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
