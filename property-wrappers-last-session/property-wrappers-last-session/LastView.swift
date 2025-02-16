//
//  LastView.swift
//  property-wrappers-last-session
//
//  Created by Pubudu Mihiranga on 2025-02-16.
//

import SwiftUI

struct LastView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.data, id: \.self) { car in
                Text(car)
            }
        }
    }
}

#Preview {
    LastView()
}
