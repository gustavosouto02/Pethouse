//
//  AddScheduleViewModel.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import Foundation
import SwiftData

@Observable
class AddScheduleViewModel {
    
    var entryDate = Date() {
        didSet {
            if exitDate <= entryDate {
                exitDate = Calendar.current.date(byAdding: .day, value: 1, to: entryDate) ?? entryDate
            }
        }
    }
    var exitDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    var pet: Pet = Pet()
    var payment: Payment? = nil
    var selectecCategory: PaymentMethod = .cash
    var dailyValue: Double = 0
    var registeredPet: Bool = false

    var totalValue: Double {
        return dailyValue
            * (Double(
                Calendar.current.dateComponents(
                    [.day],
                    from: entryDate,
                    to: exitDate
                ).day ?? 0
            ) + 1)

    }

    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")

        return formatter
    }

    func addSchedule(context: ModelContext) {


        let paymentFinal = Payment(amount: totalValue)
        paymentFinal.method = selectecCategory

            let newSchedule = Schedule(
                entryDate: entryDate,
                exitDate: exitDate,
                pet: pet,
                payment: paymentFinal,
                dailyValue: dailyValue
            )

            context.insert(paymentFinal)
            context.insert(newSchedule)
            
            

    }

    func updateSchedule(context: ModelContext, schedule: Schedule) {
            
        let paymentFinal = Payment(amount: totalValue, method: selectecCategory)

        schedule.entryDate = entryDate
        schedule.exitDate = exitDate
        schedule.pet = pet
        schedule.payment = paymentFinal
        schedule.dailyValue = dailyValue
        
        do{
            try context.save()
        }catch(_){
            print("error")
        }


    }

    func deleteSchedule(context: ModelContext, schedule: Schedule) {
        context.delete(schedule)

        do {
            try context.save()
        } catch (_) {
            print("error")
        }
    }

}
