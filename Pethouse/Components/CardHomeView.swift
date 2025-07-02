//
//  CardHomeView.swift
//  Pethouse
//
//  Created by Ana Clara Ferreira Caldeira on 02/07/25.
//

import SwiftUI

struct CardHomeView: View {
//	let schedule: Schedule
	
    var body: some View {
		VStack(alignment: .leading, spacing: 16){
			HStack(alignment: .center) {
				
				// TODO: Foto
				Circle()
					.frame(width: 40, height: 40)
				
				
				// TODO: Nome do pet
				Text("Nome do pet")
					.font(.subheadline)
				
				// TODO: Icone de status do pagamento
				Button{
					// TODO: SWITCH CASE PARA ALTERAR STATUS DO PAGAMENTO NESSE BUTTON
				} label: {
					Circle()
						.frame(width: 25, height: 25)
						.padding(.leading, 8)
						.padding(.bottom)
						.foregroundStyle(Color.greenStatus)
				}
			}
			
			HStack{
				// TODO: Nome do tutor
				Text("Tutor: tutor name")
					.font(.footnote)
					.foregroundStyle(Color.gray)
			}
			
			HStack {
				// TODO: data de entrada e saida da estadia
				Text("Date - date")
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
		.overlay(
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.accentColor, lineWidth: 1)
		)

    }
}

#Preview {
	CardHomeView()
}
