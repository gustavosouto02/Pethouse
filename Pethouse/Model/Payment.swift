//
//  Payments.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import Foundation
import SwiftData

@Model
class Payment: Identifiable {
    var id = UUID()
    var amount: Double
    var status: PaymentStatus
    var method: PaymentMethod?
    
    init(amount: Double, method: PaymentMethod? = nil) {
        self.amount = amount
        self.status = .pending
        self.method = method
    }
}

enum PaymentStatus: String, CaseIterable, Identifiable, Codable{
    var id: String { self.rawValue }
    
    case pending = "Pendente"
    case paid = "Pago"
}

enum PaymentMethod: String, CaseIterable, Identifiable, Codable{
    var id: String { self.rawValue }
    case card = "Cartão"
    case cash = "Dinheiro"
    case pix = "Pix"
}
