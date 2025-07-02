//
//  ContentView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
    
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
                        viewModel.showAddSchedule = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .sheet(isPresented: $viewModel.showAddSchedule) {
                AddScheduleView()
                    .presentationDragIndicator(.visible)
            }
        }

        .padding()
    }
}

#Preview {
    HomeView()
}
