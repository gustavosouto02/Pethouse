//
//  MockSwiftData.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 03/07/25.
//

import Foundation
import SwiftData

class MockSwiftData {
    
    func insertMockDataIfNeeded(context: ModelContext) {
        let mockData = MockData()


        for tutor in mockData.tutors {
            context.insert(tutor)
        }

        for pet in mockData.pets {
            context.insert(pet)
        }

        for payment in mockData.payments {
            context.insert(payment)
        }

//        for schedule in mockData.schedules {
//            context.insert(schedule)
//        }
    }
}
