//
//  PetTutorView.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 02/07/25.
//

import SwiftUI
import SwiftData

struct PetsView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: PetsViewModel? = nil
    @State var selectedSection = 0
    @State private var sortOrderPet = [SortDescriptor(\Pet.name)]
    @State private var sortOrderTutor = [SortDescriptor(\Tutor.name)]
    @State private var presentAddPetSheet = false
    @State private var presentAddTutorSheet = false
    @State private var presentDetailsSheet = false
    @State private var selectedPet: Pet?
    

    var body: some View {
        NavigationStack {
            VStack {
                if let viewModel = viewModel {
                    
                    List {
                        ForEach(viewModel.pets) { pet in
                            PetCard(pet: pet)
                                .onTapGesture {
                                    selectedPet = pet
                                    presentDetailsSheet = true
                                }
                                .buttonStyle(.plain)
                                .listRowSeparator(.hidden)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.deletePet(pet: pet)
                                        
                                    } label: {
                                        Label("Deletar", systemImage: "trash")
                                    }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: Binding(
                        get: { viewModel.petSearchText },
                        set: { viewModel.petSearchText = $0 }
                    ))
                    
                }
            }
            
            .navigationTitle("Pets")
            
            .onAppear {
                if viewModel == nil {
                    viewModel = PetsViewModel(context: modelContext)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if(selectedSection == 0){
                            presentAddPetSheet = true
                        } else {
                            presentAddTutorSheet = true
                        }
                    } label: {
                        Image(systemName: "plus")
                            .tint(.accentColor)
                    }
                }
            }
            
            .sheet(isPresented: $presentAddPetSheet) {
                if let viewModel = viewModel {
                    AddPetSheetView(isPresented: $presentAddPetSheet) { pet in
                        viewModel.addPet(pet)
                    }
                }
            }
            
            .sheet(isPresented: $presentDetailsSheet) {
                if let viewModel = viewModel {
                    if let pet = selectedPet {
                        NavigationStack {
                            DetailsView(pet: pet, deleteTutor: viewModel.deleteTutor)
                        }
                    }
                }
            }
            .onChange(of: presentDetailsSheet) { oldValue, newValue in
               //
            }
           
        }
        
    }
    
}


//#Preview {
//    PetTutorView()
//}
