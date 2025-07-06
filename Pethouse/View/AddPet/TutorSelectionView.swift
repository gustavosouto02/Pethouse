//
//  TutorSelectionView.swift
//  Pethouse
//
//  Created by Lizandra Malta on 04/07/25.
//

import SwiftUI
import SwiftData

struct TutorSelectionView: View {
    @Query var tutors: [Tutor]
    @Binding var selectedTutors: [Tutor]
    var onSelect:  (Tutor) -> Void
    

    
    var body: some View {
        List{
            ForEach(tutors){tutor in
                HStack {
                    Text(tutor.name)
                    Spacer()
                    if selectedTutors.contains(where: { item in
                        item.id == tutor.id
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onSelect(tutor)
                }
            }
        }
    }
}
