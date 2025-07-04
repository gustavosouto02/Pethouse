//
//  MockData.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import Foundation
import SwiftData

struct MockData {
    let tutors: [Tutor]
    let pets: [Pet]
    let payments: [Payment]
    let schedules: [Schedule]

    init() {
        tutors = [
            Tutor(name: "Ana Silva", cpf: "123.456.789-00", phone: "(11) 98765-4321"),
            Tutor(name: "Bruno Costa", cpf: "987.654.321-00", phone: "(11) 91234-5678"),
            Tutor(name: "Carlos Dias", cpf: "111.222.333-44", phone: "(21) 99887-7665")
        ]

        let buddyPayment = Payment(amount: 50.00)
        buddyPayment.status = .paid
        buddyPayment.method = .pix

        let whiskersPayment = Payment(amount: 30.00)
        whiskersPayment.status = .paid
        whiskersPayment.method = .cash

        payments = [buddyPayment, whiskersPayment]

        let buddyPet = Pet(name: "Buddy", age: 3, breed: "Golden Retriever", specie: "Cão", gender: "Macho", tutors: [tutors[0], tutors[1]])
        let whiskersPet = Pet(name: "Whiskers", age: 2, breed: "Siamês", specie: "Gato", gender: "Fêmea", tutors: [tutors[2]])

        pets = [buddyPet, whiskersPet]

        schedules = [
            Schedule(
                entryDate: Date(),
                exitDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                pet: buddyPet,
                payment: buddyPayment,
                dailyValue: 10
            ),
            Schedule(
                entryDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                exitDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                pet: whiskersPet,
                payment: whiskersPayment,
                dailyValue: 10
            )
        ]
    }
    

    
}
