//
//  PetAndTutorCard.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 02/07/25.
//

import SwiftUI

struct PetCard: View {
    var pet: Pet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                HStack{
                    ZStack {
                        if let data = pet.image, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(.gray)
                                .frame(width: 50, height: 50)
                            Image(systemName: "photo")
                                .foregroundStyle(.white)
                        }

                    }
                    
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text(pet.name)
                            .foregroundStyle(.black)
                            .font(.system(.body, design: .rounded))
                        
                        if !pet.tutors.isEmpty {
                            Text("Tutor: \(pet.tutors[0].name)")
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
    PetCard(pet: Pet(
        name: "Lucas",
        birthday: Date.now,
        breed: "Spitz Alemao",
        specie: "",
        gender: .male,
        tutors: [Tutor(
            name: "Ana",
            cpf: "",
            phone: "")]
    ))
}
