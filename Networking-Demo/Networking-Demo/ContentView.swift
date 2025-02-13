//
//  ContentView.swift
//  Networking-Demo
//
//  Created by Pubudu Mihiranga on 2025-02-13.
//

import SwiftUI

struct ContentView: View {
    @State private var albums: [Album]?
    @State private var errorDescription: String = "Something went wrong, please try again!"
    
    var body: some View {
        VStack {
            if let albums = albums {
                List(albums) { album in
                    HStack {
                        Text(album.title)
                    }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("Ooops!",
                                       systemImage: "ladybug.fill",
                                       description: Text(errorDescription))
            }
        }
        .padding()
        .task {
            do {
                albums = try await fetchAlbumData()
            } catch MyCustomError.invalidURL {
                errorDescription = "Error: MyCustomError.invalidURL"
            } catch MyCustomError.invalidResponse {
                errorDescription = "Error: MyCustomError.invalidResponse"
            } catch MyCustomError.invalidStatusCode {
                errorDescription = "Error: MyCustomError.invalidStatusCode"
            } catch MyCustomError.decodingFailed {
                errorDescription = "Error: MyCustomError.decodingFailed"
            } catch {
                errorDescription = "Error: Unexpected"
            }
        }
    }
    
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

#Preview {
    ContentView()
}
