//
//  NetworkServiceError.swift
//  WeatherApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-16.
//

import Foundation

enum NetworkServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case clientError(Int)
    case serverError(Int)
    case unexpectedStatusCode(Int)
}
