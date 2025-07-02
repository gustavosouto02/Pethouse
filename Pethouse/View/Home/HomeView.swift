//
//  ContentView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }.toolbar{
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }

        .padding()
    }
}

#Preview {
    HomeView()
}
