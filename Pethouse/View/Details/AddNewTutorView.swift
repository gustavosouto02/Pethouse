//
//  AddNewTutor.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 04/07/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddNewTutorView: View {
    @Environment(\.dismiss) var dismiss
    @State var pet: Pet
    @State private var name: String = ""
    @State private var cpf: String = ""
    @State private var phone: String = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
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
                
//                Section {
//                    HStack {
//                        Spacer()
//                        PhotoComponent()
//                        Spacer()
//                    }
//                    .listRowInsets(.none)
//                    .listRowBackground(Color.clear)
//                }
                
                Section(header: Text("Informações do Tutor")) {
                    TextField("Nome", text: $name)
                    
                    TextField("CPF", text: $cpf)
                    
                    TextField("Telefone", text: $phone)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Adicionar") {
                    let newTutor = Tutor(name: name, cpf: cpf, phone: phone, image: selectedImageData)
                    pet.tutors.append(newTutor)
                    dismiss()
                }
                .disabled(name.isEmpty || cpf.isEmpty || phone.isEmpty)
            }
        }
    }
}

//#Preview {
//    AddNewTutorView(newTutor: Tutor(name: "", cpf: "", phone: ""))
//}
