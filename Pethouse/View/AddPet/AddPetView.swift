//
//  AddPetView.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 03/07/25.
//

import SwiftUI

struct AddPetView: View {
    var body: some View {
        
        
        
        ZStack {
            Color(uiColor: UIColor.systemGroupedBackground)
                .ignoresSafeArea(edges: .all)
            VStack {
                
                PhotoComponent()
                
                Spacer()
                    
                Form{
                    Section(header: Text("Basic Information")){
                        TextField("Name", text: .constant(""))
                        TextField("Breed", text: .constant(""))
                        TextField("Especie", text: .constant(""))
                        
                        Picker("Gender", selection: .constant("Male")) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                    }
                }
                Text("Add Pet")
            }
        }
    }
}

#Preview {
    AddPetView()
}
