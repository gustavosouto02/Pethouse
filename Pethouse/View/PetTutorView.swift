//
//  PetTutorView.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 02/07/25.
//

import SwiftUI

struct PetTutorView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: PetTutorViewModel? = nil
    
    
    var body: some View {
        VStack {
            if let viewModel = viewModel {
                Button("Add pets") {
                    viewModel.addPet(name: "Lucas", age: 8, breed: "Spitz Alemao", specie: "Dog", gender: "Male")
                }
                
                List {
                    ForEach(viewModel.pets) { pet in
                        Text(pet.name)
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deletePet(pet: pet)
                                  
                                } label: {
                                    Label("Deletar", systemImage: "trash")
                                }
                            }
                    }                    
                }
                
                
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = PetTutorViewModel(context: modelContext)
            }
        }
    }
}

#Preview {
    PetTutorView()
}
