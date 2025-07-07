//
//  TutorsDetailsView.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 04/07/25.
//

import SwiftUI
import SwiftData
import PhotosUI


struct TutorsDetailsView: View {
    @State var pet: Pet
    @State var tutor: Tutor
    @State var isEditing: Bool = false
    @State var save: Bool = false
    @State private var selectedPhoto: PhotosPickerItem? = nil

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        
                        if let data = tutor.image, let image = UIImage(data: data) {
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
                                    tutor.image = data
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Informações do tutor")) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.accent)
                        Text("Nome:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(tutor.name)
                        } else {
                            TextField(tutor.name, text: $tutor.name)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                        }
                        
                    }
                    
                    HStack {
                        Image(systemName: "person.text.rectangle")
                            .foregroundStyle(.accent)
                            .frame(width: 19)
                        Text("CPF:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(tutor.cpf)
                        } else {
                            TextField(tutor.cpf, text: $tutor.cpf)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                        }
                        
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundStyle(.accent)
                            .frame(width: 19)
                        Text("Telefone:")
                        
                        Spacer()
                        
                        if !isEditing {
                            Text(tutor.phone)
                        } else {
                            TextField(tutor.phone, text: $tutor.phone)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                        }
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        isEditing.toggle()
                    } label: {
                        if isEditing {
                            Text("OK")
                        } else {
                            Text("Editar")
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    TutorsDetailsView(tutor: Tutor(name: "Ana", cpf: "9302841029", phone: "384702387"))
//}
