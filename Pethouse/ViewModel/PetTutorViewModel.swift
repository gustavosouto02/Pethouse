//
//  PetTutorViewModel.swift
//  Pethouse
//
//  Created by Ana Luisa Teixeira Coleone Reis on 02/07/25.
//

import Foundation
import SwiftData

extension PetTutorView {
    
    @Observable
    class PetTutorViewModel {
        var context: ModelContext
        var pets: [Pet] = []
        var tutors: [Tutor] = []
        var tutorSearchText: String = ""{
            didSet {
                fetchTutors()
            }
        }
        var petSearchText: String = ""{
            didSet {
                fetchPets()
            }
        }
        
        init(context: ModelContext) {
            self.context = context
            fetchAllPetAndTutors()
        }
        
//        func fetchAllPetAndTutors() {
//            do {
//                let petDescriptor = FetchDescriptor<Pet>(sortBy: [SortDescriptor(\.name)])
//                var tutorDescriptor = FetchDescriptor<Tutor>(sortBy: [SortDescriptor(\.name)])
//                
//                if !searchText.isEmpty {
//                    tutorDescriptor.predicate = #Predicate { tutor in
//                        tutor.name.localizedStandardContains(self.searchText)
//                    }
//                }
//                
//                pets = try context.fetch(petDescriptor)
//                tutors = try context.fetch(tutorDescriptor)
//                
//            } catch {
//                print("Fetch pet and tutors failed. \(error)")
//            }
//        }
        
        func fetchAllPetAndTutors() {
            fetchPets()
            fetchTutors()
        }
        
        func fetchPets() {
            do {
                let descriptor = FetchDescriptor<Pet>(sortBy: [SortDescriptor(\.name)])
                let allPets = try context.fetch(descriptor)

                if petSearchText.isEmpty {
                    pets = allPets
                } else {
                    pets = allPets.filter { $0.name.localizedStandardContains(petSearchText) }
                }
            } catch {
                print("Erro ao buscar pets: \(error)")
            }
        }

        func fetchTutors() {
            do {
                let descriptor = FetchDescriptor<Tutor>(sortBy: [SortDescriptor(\.name)])
                let allTutors = try context.fetch(descriptor)

                if tutorSearchText.isEmpty {
                    tutors = allTutors
                } else {
                    tutors = allTutors.filter { $0.name.localizedStandardContains(tutorSearchText) }
                }
            } catch {
                print("Erro ao buscar tutores: \(error)")
            }
        }
        
        func addPet(name: String, age: Int, breed: String, specie: String, gender: String) {
            let newPet = Pet(name: name, age: age, breed: breed, specie: specie, gender: gender)
            
            context.insert(newPet)
            fetchAllPetAndTutors()
        }
        
        func addTutor(name: String, cpf: String, phone: String) {
            let newTutor = Tutor(name: name, cpf: cpf, phone: phone)
            
            context.insert(newTutor)
            fetchAllPetAndTutors()
        }
        
        func deletePet(pet: Pet) {
            context.delete(pet)
            
            fetchAllPetAndTutors()
            
        }
        
        func deleteTutor(tutor: Tutor) {
            context.delete(tutor)
            
            fetchAllPetAndTutors()
            
        }
        
    }
}
