//
//  Schedule.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import Foundation
import SwiftData

@Model
class Schedule: Identifiable{
    var id = UUID()
    var entryDate : Date
    var exitDate : Date
    var pet : Pet
    @Relationship(deleteRule: .cascade) var payment: Payment
    
    init(entryDate: Date, exitDate: Date, pet: Pet, payment: Payment) {
        self.entryDate = entryDate
        self.exitDate = exitDate
        self.pet = pet
        self.payment = payment
    } 
}
