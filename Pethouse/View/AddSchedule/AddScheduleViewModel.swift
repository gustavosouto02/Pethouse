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
    
    init(){
    }
    
}
