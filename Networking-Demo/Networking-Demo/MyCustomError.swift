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
}
