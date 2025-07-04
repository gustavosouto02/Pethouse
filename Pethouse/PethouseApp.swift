//
//  PethouseApp.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftUI
import SwiftData

@main
struct PethouseApp: App {
    var body: some Scene {
        WindowGroup {
            
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                PetTutorView()
                    .tabItem {
                        Image(systemName: "pawprint.fill")
                    }
            }
            
        }
        .modelContainer(for: [Payment.self, Pet.self, Schedule.self, Tutor.self])
    }
}
