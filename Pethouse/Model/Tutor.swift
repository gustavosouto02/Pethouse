//
//  Tutor.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import Foundation
import SwiftData

@Model
class Tutor: Identifiable {
    var id = UUID()
    var name: String
    var cpf: String
    var phone: String
    var image: Data?
    
    @Relationship(inverse: \Pet.tutors) var pets: [Pet]
    
    init(name: String, cpf: String, phone: String, image: Data? = nil, pets: [Pet] = []) {
        self.name = name
        self.cpf = cpf
        self.phone = phone
        self.image = image
        self.pets = pets
    }
}
