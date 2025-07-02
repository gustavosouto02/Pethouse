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
        
        init(context: ModelContext) {
            self.context = context
            fetchAllPetAndTutors()
        }
        
        func fetchAllPetAndTutors() {
            do {
                let petDescriptor = FetchDescriptor<Pet>(sortBy: [SortDescriptor(\.name)])
                let tutorDescriptor = FetchDescriptor<Tutor>(sortBy: [SortDescriptor(\.name)])
                
                pets = try context.fetch(petDescriptor)
                tutors = try context.fetch(tutorDescriptor)
                
            } catch {
                print("Fetch pet and tutors failed. \(error)")
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
    }
}
