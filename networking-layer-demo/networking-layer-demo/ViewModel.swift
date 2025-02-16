//
//  ViewModel.swift
//  networking-layer-demo
//
//  Created by Pubudu Mihiranga on 2025-02-16.
//

import Foundation

struct TodoDTO: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id
        case title
        case completed
    }
}

enum MyAppError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case decodingFailed
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Error: Invalid URL"
        case .invalidResponse:
            return "Error: Invalid Response"
        case .invalidStatusCode:
            return "Error: Invalid Status Code"
        case .decodingFailed:
            return "Error: Decoding Failed"
        case .unknown:
            return "Unknown Error"
        }
    }
}

enum LoadingState {
    case idle
    case loading
    case success([TodoDTO])
    case error(MyAppError)
}

@MainActor
class ViewModel: ObservableObject {
    @Published var state: LoadingState = .idle
    
    init() {
        callRepository()
    }
    
    // fetch from cache or fetch from internet
    func callRepository() {
        Task {
            state = .loading
            do {
                let todos = try await fetchData()
                state = .success(todos)
            } catch {
                state = .error(MyAppError.unknown)
            }
        }
    }
    
    func fetchData() async throws -> [TodoDTO] {
        // step 1 - construct URL
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        guard let url = URL(string: urlString) else {
            throw MyAppError.invalidURL
        }
        
        // step 2 - create URL session
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // step 3 - check for success response
        guard let reponse = response as? HTTPURLResponse else {
            throw MyAppError.invalidResponse
        }
        
        // step 4 - check for status code
        switch reponse.statusCode {
        case 200:
            // handle success
            // step 5 - decoding
            do {
                let todos = try JSONDecoder().decode([TodoDTO].self, from: data)
                return todos
            } catch {
                throw MyAppError.decodingFailed
            }
        case 400:
            // handle 400 erros
            throw MyAppError.invalidStatusCode
        case 500:
            // handle server error
            throw MyAppError.invalidStatusCode
        default:
            throw MyAppError.unknown
        }
    }
}
