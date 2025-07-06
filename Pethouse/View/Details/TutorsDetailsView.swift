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
                    .listRowInsets(.none)
                    .listRowBackground(Color.clear)
                }
                
                Section(header: Text("Informações do tutor")) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.accent)
                        Text("Nome:")
                        
                        Spacer()
                        
                        Text(tutor.name)
                    }
                    
                    HStack {
                        Image(systemName: "person.text.rectangle")
                            .foregroundStyle(.accent)
                            .frame(width: 19)
                        Text("CPF:")
                        
                        Spacer()
                        
                        Text(tutor.cpf)
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundStyle(.accent)
                            .frame(width: 19)
                        Text("Telefone:")
                        
                        Spacer()
                        
                        Text(tutor.phone)
                    }
                }
            }
        }
    }
}

//#Preview {
//    TutorsDetailsView(tutor: Tutor(name: "Ana", cpf: "9302841029", phone: "384702387"))
//}
