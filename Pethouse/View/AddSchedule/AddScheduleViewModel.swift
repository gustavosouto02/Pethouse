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

    var entryDate = Date()
    var exitDate = Date()
    var pet: Pet? = nil
    var payment: Payment? = nil
    var selectecCategory: PaymentMethod = .cash
    var dailyValue: Double = 0
    var registeredPet: Bool = false
    var showAddPetView: Bool = false

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

        guard let Wpet = pet else {
            return
        }

        let paymentFinal = Payment(amount: totalValue)

        let newSchedule = Schedule(
            entryDate: entryDate,
            exitDate: exitDate,
            pet: Wpet,
            payment: paymentFinal,
            dailyValue: dailyValue
        )

        context.insert(paymentFinal)
        context.insert(newSchedule)

    }

    func updateSchedule(context: ModelContext, schedule: Schedule) {

        guard let Wpet = pet else {
            return
        }
        let paymentFinal = Payment(amount: totalValue)

        schedule.entryDate = entryDate
        schedule.exitDate = exitDate
        schedule.pet = Wpet
        schedule.payment = paymentFinal
        schedule.dailyValue = dailyValue

        do {
            try context.save()
        } catch (_) {
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
