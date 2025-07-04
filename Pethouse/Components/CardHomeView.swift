//
//  CardHomeView.swift
//  Pethouse
//
//  Created by Ana Clara Ferreira Caldeira on 02/07/25.
//

import SwiftUI

struct CardHomeView: View {

    var schedule: Schedule

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {

                // TODO: Foto
                Circle()
                    .foregroundStyle(Color("PurpleStatus"))
                    .frame(width: 40, height: 40)
                    .overlay(content: {
                        Image(systemName: "dog.fill")
                            .foregroundStyle(Color.white)
                    })

                // TODO: Nome do pet
                Text(schedule.pet.name)
                    .font(.subheadline)
            }

            HStack {
                // TODO: Nome do tutor
                Text("Tutor: \(schedule.pet.tutors[0].name)")
                    .font(.footnote)
                    .foregroundStyle(Color.gray)
            }

            HStack {
                let entrada = schedule.entryDate.formatted(
                    .dateTime.day().month(.abbreviated).locale(
                        Locale(identifier: "pt_BR")
                    )
                )
                let saida = schedule.exitDate.formatted(
                    .dateTime.day().month(.abbreviated).locale(
                        Locale(identifier: "pt_BR")
                    )
                )

                Text("\(entrada) - \(saida)")
                    .frame(width: 110, height: 18)
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.accentColor)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())

                Image(systemName: "arrowtriangle.right.fill")
                    .frame(width: 12, height: 12)
                    .foregroundStyle(Color.accentColor)
                    .padding(.leading, 15)
            }

        }
        .padding()
        .frame(width: 200, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)

        )

        //		.overlay(
        //			RoundedRectangle(cornerRadius: 20)
        //				.stroke(Color.accentColor, lineWidth: 1.5)
        //
        //		)

    }
}

#Preview {

    var schedule = MockData().schedules[0]

    CardHomeView(schedule: schedule)
}
