////
////  PetView.swift
////  Pethouse
////
////  Created by Ana Luisa Teixeira Coleone Reis on 03/07/25.
////
//
//import SwiftUI
//import SwiftData
//
//struct PetView: View {
//    @Environment(\.modelContext) var model
//    @Query var pets: [Pet]
//    
//    var body: some View {
//        List {
//            ForEach(pets) { pet in
//                PetCard(pet: pet)
//                    .buttonStyle(.plain)
//                    .listRowSeparator(.hidden)
//                    .swipeActions {
//                        Button(role: .destructive) {
//                            model.delete(pet)
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
//    init(searchString: String = "", sortOrder: [SortDescriptor<Pet>] = []) {
//        _pets = Query(filter: #Predicate { pet in
//            if searchString.isEmpty {
//                true
//            } else {
//                pet.name.localizedStandardContains(searchString)
//            }
//        }, sort: sortOrder)
//    }
//    
//}
//
//#Preview {
//    PetView()
//}
