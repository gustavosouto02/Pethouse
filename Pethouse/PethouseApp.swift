//
//  PethouseApp.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftData
import SwiftUI

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
                PaymentView()
                    .tabItem {
                        Image(systemName: "dollarsign")
                    }
            }

        }
        .modelContainer(for: [
            Payment.self, Pet.self, Schedule.self, Tutor.self,
        ])
    }
}
