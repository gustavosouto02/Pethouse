////
////  TutorView.swift
////  Pethouse
////
////  Created by Ana Luisa Teixeira Coleone Reis on 03/07/25.
////
//
//import SwiftUI
//import SwiftData
//
//struct TutorView: View {
//    @Environment(\.modelContext) var model
//    @Query var tutors: [Tutor]
//    
//    var body: some View {
//        List {
//            ForEach(tutors) { tutor in
//                TutorCard(tutor: tutor)
//                    .buttonStyle(.plain)
//                    .listRowSeparator(.hidden)
//                    .swipeActions {
//                        Button(role: .destructive) {
//                            model.delete(tutor)
//                            try? model.save()
//                            
//                        } label: {
//                            Label("Deletar", systemImage: "trash")
//                        }
//                    }
//            }
//        }
//        .listStyle(.plain)
//    }
//    
//    init(searchString: String = "", sortOrder: [SortDescriptor<Tutor>] = []) {
//        _tutors = Query(filter: #Predicate { tutor in
//            if searchString.isEmpty {
//                true
//            } else {
//                tutor.name.localizedStandardContains(searchString)
//            }
//        }, sort: sortOrder)
//    }
//    
//}
//
//#Preview {
//    TutorView()
//}
