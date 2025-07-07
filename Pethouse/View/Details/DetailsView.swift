//
//  DetailsView.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 04/07/25.
//

import SwiftUI
import SwiftData
import PhotosUI


struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var pet: Pet
    @State var deleteTutor: (Tutor) -> Void
    @State var isEditing: Bool = false
    @State private var selectedPhoto: PhotosPickerItem? = nil
    
    var body: some View {
            Form {
                Section {
                    HStack {
                        Spacer()
                        if let data = pet.image, let image = UIImage(data: data) {
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
                    
                    if isEditing {
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
                                    pet.image = data
                                }
                            }
                        }
                    }
                }
                
                
                Section(header: Text("Informações do pet")) {
                    HStack {
                        Image(systemName: "pawprint.fill")
                            .foregroundStyle(.accent)
                        Text("Nome:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(pet.name)
                        } else {
                            TextField(pet.name, text: $pet.name)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                        }
                        
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.accent)
                        Text("Data de Nascimento:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(pet.birthday.formatted(date: .abbreviated, time: .omitted))
                        } else {
                            DatePicker("", selection: $pet.birthday,  in: ...Date.now, displayedComponents: .date)
                                .frame(width: 100)
                        }
                        
                    }
                    
                    HStack {
                        Image(systemName: "doc.text.magnifyingglass")
                            .foregroundStyle(.accent)
                        Text("Raça:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(pet.breed)
                        } else {
                            TextField(pet.breed, text: $pet.breed)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                        }
                        
                    }
                    
                    HStack {
                        Image(systemName: pet.specie == .cat ? "cat.fill" : "dog.fill")
                            .foregroundStyle(.accent)
                            .frame(width: 18)
                        Text("Espécie:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(pet.specie.rawValue)
                        } else {
                            Picker("", selection: $pet.specie) {
                                Text("Cachorro").tag(Specie.dog)
                                Text("Gato").tag(Specie.cat)
                            }
                            .frame(width: 150)
                        }
                    }
                    
                    HStack {
                        Text(pet.gender == .male ? "♂" : "♀")
                            .foregroundStyle(.accent)
                            .font(.title3)
                            .frame(width: 18)
                        Text("Gênero:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(pet.gender.rawValue)
                        } else {
                            Picker("", selection: $pet.gender) {
                                Text("Macho").tag(Gender.male)
                                Text("Fêmea").tag(Gender.female)
                            }
                            .frame(width: 150)
                        }
                    }
                }
                
                if !isEditing {
                    Section(header: Text("Tutores")) {
                        List {
                            ForEach(pet.tutors) { tutor in
                                NavigationLink(destination: TutorsDetailsView(pet: pet, tutor: tutor)) {
                                    Image(systemName: "person.fill")
                                        .foregroundStyle(.accent)
                                    Text(tutor.name)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteTutor(tutor)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                            }
                            
                            NavigationLink { AddNewTutorView(pet: pet)
                            } label: {
                                Text("Adicione um novo tutor")
                            }
                            
                        }
                        
                        
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing.toggle()
                    }, label: {
                        if !isEditing {
                            Text("Editar")
                        } else {
                            Text("OK")
                        }
                        
                    })
                }
            }
    }
}

//#Preview {
//    DetailsView(pet: Pet(name: "Lucas", birthday: .now, breed: "Spitz", specie: "Cachorro", gender: .male, tutors: [Tutor(name: "Ana", cpf: "093840", phone: "23098408")]))
//}
