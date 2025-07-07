//
//  AddPetSheetView.swift
//  Pethouse
//
//  Created by Lizandra Malta on 02/07/25.
//

import SwiftUI
import PhotosUI

struct AddPetSheetView: View {
    @Binding var isPresented: Bool
    var onAdd: (Pet) -> Void
    
    @State private var name = ""
    @State private var specie: Specie = .dog
    @State private var breed = ""
    @State private var birthday = Date.now
    @State private var gender: Gender = .male
    @State private var details: String = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    enum TutorInputType: String, CaseIterable, Identifiable {
        case select = "Selecionar existente"
        case new = "Cadastrar novo"
        var id: String { self.rawValue }
    }
    
    @State private var tutorInputType: TutorInputType = .select
    
    @State private var selectedTutor: Tutor?
    @State private var addedTutors: [Tutor] = []
    @State private var newTutorName = ""
    @State private var newTutorCPF = ""
    @State private var newTutorPhone = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        
                        if let data = selectedImageData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        } else {
                            PhotoComponent()
                        }
                        
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(.none)
                    .listRowBackground(Color.clear)
                    
                    
                    HStack {
                        Spacer()
                        
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            Text("Selecionar Foto")
                        }
                        
                        Spacer()
                    }
                    .listRowInsets(.none)
                    .listRowBackground(Color.clear)
                    .onChange(of: selectedPhoto) {
                        Task {
                            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                }
                
                Section(header: Text("Informações básicas")) {
                    TextField("Nome", text: $name)
                    
                    Picker("Espécie", selection: $specie) {
                        Text("Cachorro").tag(Specie.dog)
                        Text("Gato").tag(Specie.cat)
                    }
                    
                    TextField("Raça", text: $breed)
                    
                    DatePicker("Aniversário", selection: $birthday,  in: ...Date.now, displayedComponents: .date)
                    
                    Picker("Gênero", selection: $gender) {
                        Text("Macho").tag(Gender.male)
                        Text("Fêmea").tag(Gender.female)
                    }
                }
                
                
                Section(header: Text("Tutores")) {
                    Picker("Opção", selection: $tutorInputType) {
                        ForEach(TutorInputType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if tutorInputType == .select {
                        NavigationLink {
                            TutorSelectionView(selectedTutors: $addedTutors){tutor in
                                let tutorAlredyAddedIndex = addedTutors.firstIndex { item in
                                    item.id == tutor.id
                                }
                                if let tutorToBeRemoved = tutorAlredyAddedIndex {
                                    addedTutors.remove(at: tutorToBeRemoved)
                                }else {
                                    addedTutors.append(tutor)
                                }
                            }
                        } label: {
                            Text("Selecione um tutor")
                        }
                    }
                    
                    if tutorInputType == .new {
                        TextField("Nome", text: $newTutorName)
                        TextField("CPF", text: $newTutorCPF)
                        TextField("Telefone", text: $newTutorPhone)
                        
                        Button {
                            let newTutor = Tutor(name: newTutorName, cpf: newTutorCPF, phone: newTutorPhone)
                            addedTutors.append(newTutor)
                            selectedTutor = newTutor
                            newTutorName = ""
                            newTutorCPF = ""
                            newTutorPhone = ""
                            tutorInputType = .select
                        } label: {
                            Label("Adicionar Tutor", systemImage: "plus")
                        }
                        .disabled(newTutorName.isEmpty || newTutorCPF.isEmpty || newTutorPhone.isEmpty)
                    }
                    
                    
                }
                
                if !addedTutors.isEmpty {
                    Section {
                        ForEach(addedTutors) { tutor in
                            HStack {
                                Text(tutor.name)
                                Spacer()
                                Button(role: .destructive) {
                                    addedTutors.removeAll { $0 == tutor }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Detalhes (opcional)")) {
                    TextEditor(text: $details)
                        .frame(height: 150)
                }
                
            }
            .navigationTitle("Adicionar Pet")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        isPresented = false
                    }
                    .foregroundStyle(.red)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Adicionar") {
                        let newPet = Pet(name: name, birthday: birthday, breed: breed, specie: specie, gender: gender, details: details, tutors: addedTutors, image: selectedImageData)
                        onAdd(newPet)
                        isPresented = false
                    }
                    .disabled(name.isEmpty || specie.rawValue.isEmpty || breed.isEmpty)
                }
            }
        }
    }
}


#Preview {
    AddPetSheetView(isPresented: .constant(true)){_ in
        
    }
}
