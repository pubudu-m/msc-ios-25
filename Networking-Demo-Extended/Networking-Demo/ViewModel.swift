//
//  ViewModel.swift
//  Networking-Demo
//
//  Created by Pubudu Mihiranga on 2025-02-13.
//

import Foundation

enum AppState {
    case idle
    case loading
    case success([Album])
    case failure(MyCustomError)
}

class ViewModel: ObservableObject {
    @Published var state: AppState = .idle
    
    // ideally we shouod have getData within our ViewModel
    func getData() {
        Task {
            state = .loading
            do {
                let albums = try await fetchAlbumData()
                state = .success(albums)
            } catch let error as MyCustomError {
                state = .failure(error)
            } catch {
                state = .failure(MyCustomError.unknown)
            }
        }
    }
    
    // we should move this func to new file for loose couple code
    func fetchAlbumData() async throws -> [Album] {
        
        // step 1 - contruct the url
        let urlString = "https://jsonplaceholder.typicode.com/albums"
        guard let url = URL(string: urlString) else {
            throw MyCustomError.invalidURL
        }
        
        // step 2 - url session
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // step 3 - if the received response if valid
        guard let response = response as? HTTPURLResponse else {
            throw MyCustomError.invalidResponse
        }
        
        guard response.statusCode == 200 else {
            throw MyCustomError.invalidStatusCode
        }
        
        do {
            return try JSONDecoder().decode([Album].self, from: data)
            
        } catch {
            throw MyCustomError.decodingFailed
        }
    }
}
