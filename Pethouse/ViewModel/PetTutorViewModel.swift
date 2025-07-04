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
        
        func addPet(_ newPet: Pet) {
            context.insert(newPet)
            do {
                try context.save()
                fetchAllPetAndTutors()
            } catch {
                print("Erro ao salvar pet: \(error)")
            }
        }
        
        func addTutor(_ newTutor: Tutor) {

            context.insert(newTutor)
            do {
                try context.save()
                fetchAllPetAndTutors()
            } catch {
                print("Erro ao salvar tutor: \(error)")
            }
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
