//
//  Pet.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import Foundation
import SwiftData


@Model
class Pet: Identifiable {
    var id = UUID()
    var name: String
    var age: Int
    var breed: String //raça
    var specie: String // especie
    var gender: String
    var details: String?
    var tutors: [Tutor]
    @Relationship(deleteRule: .cascade, inverse: \Schedule.pet) var schedules: [Schedule]?

    init(name: String, age: Int, breed: String, specie: String, gender: String, tutors: [Tutor] = []) {
        self.name = name
        self.age = age
        self.breed = breed
        self.specie = specie
        self.gender = gender
        self.tutors = tutors
    }
}
