//
//  MyCustomError.swift
//  Networking-Demo
//
//  Created by Pubudu Mihiranga on 2025-02-13.
//

import Foundation

enum MyCustomError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case decodingFailed
    case unknown
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "invalidURL"
        case .invalidResponse:
            return "invalidResponse"
        case .invalidStatusCode:
            return "invalidStatusCode"
        case .decodingFailed:
            return "decodingFailed"
        case .unknown:
            return "unknown"
        }
    }
}
