//
//  AddPetSheetView.swift
//  Pethouse
//
//  Created by Lizandra Malta on 02/07/25.
//

import SwiftUI

struct AddPetSheetView: View {
    @Binding var isPresented: Bool
    @State var tutors: [Tutor] = []
    var onAdd: (Pet) -> Void
    
    @State private var name = ""
    @State private var specie = ""
    @State private var breed = ""
    @State private var birthday = Date.now
    @State private var gender: Gender = .male
    @State private var details: String = ""
    
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
                Section(header: Text("Informações básicas")){
                    TextField("Nome", text: $name)
                    TextField("Espécie", text: $specie)
                    TextField("Raça", text: $breed)
                    
                    DatePicker("Aniversário", selection: $birthday, displayedComponents: .date)
                    
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
                        Picker("Selecionar Tutor", selection: $selectedTutor) {
                            Text("Selecione um tutor").tag(Optional<Tutor>.none)
                            ForEach(tutors) { tutor in
                                Text(tutor.name).tag(Optional(tutor))
                            }
                        }
                        
                        if let selectedTutor {
                            Button {
                                if !addedTutors.contains(selectedTutor) {
                                    addedTutors.append(selectedTutor)
                                }
                            } label: {
                                Label("Adicionar Tutor", systemImage: "plus")
                            }
                        }
                    }
                    
                    if tutorInputType == .new {
                        TextField("Nome", text: $newTutorName)
                        TextField("CPF", text: $newTutorCPF)
                        TextField("Telefone", text: $newTutorPhone)
                        
                        Button {
                            let newTutor = Tutor(name: newTutorName, cpf: newTutorCPF, phone: newTutorPhone)
                            tutors.append(newTutor)
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
                    
                    
                    if !addedTutors.isEmpty {
                        Section(header: Text("Tutores adicionados")) {
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
                        let newPet = Pet(name: name, birthday: birthday, breed: breed, specie: specie, gender: gender, details: details, tutors: addedTutors)
                        onAdd(newPet)
                        isPresented = false
                    }
                    .disabled(name.isEmpty || specie.isEmpty || breed.isEmpty)
                }
            }
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    AddPetSheetView(isPresented: .constant(true)){_ in
        
    }
}
