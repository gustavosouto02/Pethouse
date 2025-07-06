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
        
    var body: some View {
        NavigationStack {
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
                    .listRowInsets(.none)
                    .listRowBackground(Color.clear)
                }
                
                    
                Section(header: Text("Informações do pet")) {
                    HStack {
                        Image(systemName: "pawprint.fill")
                            .foregroundStyle(.accent)
                        Text("Nome:")
                        
                        Spacer()
                        
                        Text(pet.name)
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.accent)
                        Text("Data de Nascimento:")
                        
                        Spacer()
                        
                        Text(pet.birthday.formatted(date: .abbreviated, time: .omitted))
                    }
                    
                    HStack {
                        Image(systemName: "doc.text.magnifyingglass")
                            .foregroundStyle(.accent)
                        Text("Raça:")
                        
                        Spacer()
                        
                        Text(pet.breed)
                    }
                    
                    HStack {
                        Image(systemName: pet.specie.lowercased() == "gato" ? "cat.fill" : "dog.fill")
                            .foregroundStyle(.accent)
                            .frame(width: 18)
                        Text("Espécie:")
                        
                        Spacer()
                        
                        Text(pet.specie)
                    }
                    
                    HStack {
                        Text(pet.gender == .male ? "♂" : "♀")
                            .foregroundStyle(.accent)
                            .font(.title3)
                            .frame(width: 18)
                        Text("Gênero:")
                        
                        Spacer()
                        
                        Text(pet.gender.rawValue)
                    }
                }
                
                
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
        .navigationTitle(pet.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("OK")
                })
            }
        }
    }
}

//#Preview {
//    DetailsView(pet: Pet(name: "Lucas", birthday: .now, breed: "Spitz", specie: "Cachorro", gender: .male, tutors: [Tutor(name: "Ana", cpf: "093840", phone: "23098408")]))
//}
