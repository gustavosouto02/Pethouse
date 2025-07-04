//
//  AddScheduleButton.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import SwiftUI

struct AddScheduleButton: View {
    var body: some View {
        HStack{
            Text("Agendar")
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(Color.white)
            Image(systemName: "plus")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.white)

        }
        .frame(width: 120, height: 40)
        .background(Color("CyanColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    AddScheduleButton()
}
