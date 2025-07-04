//
//  HomeViewModel.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import Foundation
import SwiftData

@Observable
class HomeViewModel {
    let schedules = MockData().schedules
    var showAddSchedule: Bool = false
    var mock = MockSwiftData()
    
    func filterCurrentSchedules(from schedules: [Schedule]) -> [Schedule] {
        schedules.filter { $0.entryDate <= Date() }
    }

    func filterFutureSchedules(from schedules: [Schedule]) -> [Schedule] {
        schedules.filter { $0.entryDate > Date() }
    }
    
    func insertDefaultDataIfNeeded(context: ModelContext, didInsertDefaults: inout Bool) {
        if !didInsertDefaults {
            mock.insertMockDataIfNeeded(context: context)
            didInsertDefaults = true
        }
    }
    

    
}
