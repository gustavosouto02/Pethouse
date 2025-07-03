//
//  TutorCard.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 02/07/25.
//

import SwiftUI

struct TutorCard: View {
    var tutor: Tutor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                HStack{
                    ZStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 50, height: 50)
                        Image(systemName: "photo")
                            .foregroundStyle(.white)
                    }
                    
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text(tutor.name)
                            .foregroundStyle(.black)
                            .font(.system(.body, design: .rounded))
                        
                        if !tutor.pets.isEmpty {
                            Text("Pet: \(tutor.pets[0].name)")
                                .font(.system(.body, design: .rounded))
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundStyle(.accent)
                        .padding(.horizontal)


                }
            }
        }
        .frame(maxWidth: 345)
        .padding(.horizontal, -4)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    TutorCard(tutor: Tutor(
        name: "Ana",
        cpf: "",
        phone: "", pets: [Pet(
            name: "Lucas",
            age: 7,
            breed: "",
            specie: "",
            gender: "")
        ]))
}

