//
//  AddScheduleViewModel.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import Foundation

@Observable
class AddScheduleViewModel{
    
    var entryDate = Date()
    var exitDate = Date()
    var pet: Pet? = nil
    var payment: Payment? = nil
    var selectecCategory: PaymentMethod = .cash
    var dailyValue: Double = 0
    var registeredPet: Bool = false
    
    
    var mockPets: [Pet] = MockData().pets
    
    var totalValue: Double {
        return dailyValue * (Double(Calendar.current.dateComponents([.day], from: entryDate, to: exitDate).day ?? 0) + 1)
        
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        return formatter
    }
    
    init(){
    }
    
}
