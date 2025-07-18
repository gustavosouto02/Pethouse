//
//  Pet.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import Foundation
import SwiftData


@Model
class Pet: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var birthday: Date
    var breed: String //raça
    var specie: Specie // especie
    var gender: Gender
    var details: String?
    var tutors: [Tutor]
    var image: Data?
    
    @Relationship(deleteRule: .cascade, inverse: \Schedule.pet) var schedules: [Schedule]?

    init(name: String, birthday: Date, breed: String, specie: Specie, gender: Gender, details: String = "", tutors: [Tutor] = [], image: Data? = nil) {
        self.name = name
        self.birthday = birthday
        self.breed = breed
        self.specie = specie
        self.gender = gender
        self.details = details
        self.tutors = tutors
        self.image = image
    }
    
    init(){
        self.name = ""
        self.birthday = .now
        self.breed = ""
        self.specie = .dog
        self.gender = .female
        self.details = ""
        self.tutors = []
    }
}

enum Gender: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    
    case male = "Macho"
    case female = "Fêmea"
}

enum Specie: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    
    case dog = "Cachorro"
    case cat = "Gato"
}
