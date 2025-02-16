//
//  ViewModel.swift
//  property-wrappers-last-session
//
//  Created by Pubudu Mihiranga on 2025-02-16.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var data: [String] = []
    
    init() {
        getData()
    }
    
    private func getData() {
        data.append(contentsOf: ["bmw", "mercedes", "volkswagen", "tesla", "toyota"])
    }
}
