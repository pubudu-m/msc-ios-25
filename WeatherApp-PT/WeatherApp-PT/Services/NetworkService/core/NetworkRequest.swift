//
//  NetworkRequest.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-16.
//

import Foundation

protocol NetworkRequest {
    var scheme: NetworkScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameteres: [URLQueryItem] { get }
    var method: NetworkMethod { get }
}

extension NetworkRequest {
    func buildURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = parameteres
        return components
    }
}

