//
//  AddTutorSheetView.swift
//  Pethouse
//
//  Created by Lizandra Malta on 04/07/25.
//

import SwiftUI

struct AddTutorSheetView: View {
    @Binding var isPresented: Bool
    var pets: [Pet] = []
    var onAdd: (Tutor) -> Void

    @State private var name = ""
    @State private var cpf = ""
    @State private var phone = ""

    enum PetInputType: String, CaseIterable, Identifiable {
        case select = "Selecionar existente"
        case new = "Cadastrar novo"
        var id: String { self.rawValue }
    }

    @State private var petInputType: PetInputType = .select

    @State private var selectedPet: Pet?
    @State private var addedPets: [Pet] = []
    @State private var newPetName = ""
    @State private var newPetSpecie = ""
    @State private var newPetBreed = ""
    @State private var newPetBirthday = Date.now
    @State private var newPetGender: Gender = .male
    @State private var newPetDetails = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Informações do Tutor")) {
                    TextField("Nome", text: $name)
                    TextField("CPF", text: $cpf)
                    TextField("Telefone", text: $phone)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Pets")) {
                    Picker("Opção", selection: $petInputType) {
                        ForEach(PetInputType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if petInputType == .select {
                        Picker("Selecionar Pet", selection: $selectedPet) {
                            Text("Selecione um pet").tag(Optional<Pet>.none)
                            ForEach(pets) { pet in
                                Text(pet.name).tag(Optional(pet))
                            }
                        }

                        if let selectedPet {
                            Button {
                                if !addedPets.contains(selectedPet) {
                                    addedPets.append(selectedPet)
                                }
                            } label: {
                                Label("Adicionar Pet", systemImage: "plus")
                            }
                        }
                    }

                    if petInputType == .new {
                        TextField("Nome", text: $newPetName)
                        TextField("Espécie", text: $newPetSpecie)
                        TextField("Raça", text: $newPetBreed)
                        DatePicker("Aniversário", selection: $newPetBirthday, displayedComponents: .date)

                        Picker("Gênero", selection: $newPetGender) {
                            Text("Macho").tag(Gender.male)
                            Text("Fêmea").tag(Gender.female)
                        }

                        TextEditor(text: $newPetDetails)
                            .frame(height: 100)

                        Button {
                            let newPet = Pet(
                                name: newPetName,
                                birthday: newPetBirthday,
                                breed: newPetBreed,
                                specie: newPetSpecie,
                                gender: newPetGender,
                                details: newPetDetails,
                                tutors: [] // tutors será adicionado depois
                            )
                            addedPets.append(newPet)
                            newPetName = ""
                            newPetSpecie = ""
                            newPetBreed = ""
                            newPetDetails = ""
                            newPetGender = .male
                            newPetBirthday = Date.now
                            petInputType = .select
                        } label: {
                            Label("Adicionar Pet", systemImage: "plus")
                        }
                        .disabled(newPetName.isEmpty || newPetSpecie.isEmpty || newPetBreed.isEmpty)
                    }

                    if !addedPets.isEmpty {
                        Section(header: Text("Pets adicionados")) {
                            ForEach(addedPets) { pet in
                                HStack {
                                    Text(pet.name)
                                    Spacer()
                                    Button(role: .destructive) {
                                        addedPets.removeAll { $0 == pet }
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Adicionar Tutor")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        isPresented = false
                    }
                    .foregroundStyle(.red)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Adicionar") {
                        let newTutor = Tutor(name: name, cpf: cpf, phone: phone, pets: addedPets)
                        onAdd(newTutor)
                        isPresented = false
                    }
                    .disabled(name.isEmpty || cpf.isEmpty || phone.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTutorSheetView(isPresented: .constant(true), pets: []) { _ in }
}
