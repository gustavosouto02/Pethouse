//
//  PetTutorView.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 02/07/25.
//

import SwiftUI
import SwiftData

struct PetTutorView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: PetTutorViewModel? = nil
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
                    
                    Picker("", selection: $selectedSection) {
                        Text("Pets")
                            .tag(0)
                        
                        Text("Tutores")
                            .tag(1)
                    }
                    .pickerStyle(.palette)
                    .colorMultiply(.accentColor)
                    .padding(.horizontal, 24)
                    
                    
                    if selectedSection == 0 {
                        List {
                            ForEach(viewModel.pets) { pet in
                                PetCard(pet: pet)
                                    .buttonStyle(.plain)
                                    .listRowSeparator(.hidden)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            viewModel.deletePet(pet: pet)
                                            
                                        } label: {
                                            Label("Deletar", systemImage: "trash")
                                        }
                                    }
                                    .onTapGesture {
                                        presentDetailsSheet.toggle()
                                        selectedPet = pet
                                    }
                                
                            }
                            
                            
                        }
                        .listStyle(.plain)
                        .searchable(text: Binding(
                            get: { viewModel.petSearchText },
                            set: { viewModel.petSearchText = $0 }
                        ))
                        //PetView(searchString: searchingString, sortOrder: sortOrderPet)
                        
                    } else {
                        List {
                            ForEach(viewModel.tutors) { tutor in
                                TutorCard(tutor: tutor)
                                    .buttonStyle(.plain)
                                    .listRowSeparator(.hidden)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            viewModel.deleteTutor(tutor: tutor)
                                        } label: {
                                            Label("Deletar", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .listStyle(.plain)
                        .searchable(text: Binding(
                            get: { viewModel.tutorSearchText },
                            set: { viewModel.tutorSearchText = $0 }
                        ))
                        //TutorView(searchString: searchingString, sortOrder: sortOrderTutor)
                    }
                }
            }
            
            .navigationTitle("Title")
            
            .onAppear {
                if viewModel == nil {
                    viewModel = PetTutorViewModel(context: modelContext)
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
                    AddPetSheetView(isPresented: $presentAddPetSheet, tutors: viewModel.tutors) { pet in
                        viewModel.addPet(pet)
                    }
                }
            }
            
            .sheet(isPresented: $presentDetailsSheet) {
                if let viewModel = viewModel {
                    if let pet = selectedPet {
                        DetailsView(pet: pet, deleteTutor: viewModel.deleteTutor)
                    }
                }
            }
            
           
        }
        
    }
    
}


//#Preview {
//    PetTutorView()
//}
