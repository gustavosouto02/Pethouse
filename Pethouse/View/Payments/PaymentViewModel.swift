//
//  PaymentViewModel.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 04/07/25.
//

import Foundation
import SwiftData
import SwiftUI

class PaymentViewModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func togglePaymentStatus(_ payment: Payment) {
        payment.status = (payment.status == .pending) ? .paid : .pending
        try? context.save()
    }
}

struct PaymentSection: View {
    var items: [Schedule]
    var colorStatus: Color
    var onMarkAsPaid: ((Payment) -> Void)? = nil

    var body: some View {
        LazyVGrid(columns: [GridItem()], spacing: 16) {
            ForEach(items) { schedule in
                CardPayment(
                    schedule: schedule,
                    statusColor: colorStatus,
                    onMarkAsPaid: { onMarkAsPaid?(schedule.payment) }
                )
            }
        }
        .padding(.horizontal)
    }
}

struct CardPayment: View {
    var schedule: Schedule
    var statusColor: Color
    var onMarkAsPaid: (() -> Void)? = nil

    @State private var showActions = false

    var body: some View {
        let pet = schedule.pet
        let payment = schedule.payment

        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 20) {
                
                if let data = schedule.pet.tutors.first?.image, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } else {
                    PhotoComponent()
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(pet.tutors.first?.name ?? "Tutor desconhecido")
                        .font(.title3)
                        .lineLimit(1)

                    Text("Pet: \(pet.name)")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }

                Spacer()

                Circle()
                    .fill(statusColor)
                    .frame(width: 20, height: 20)
            }

            Text("R$ \(payment.amount, specifier: "%.2f") - \(payment.method?.rawValue ?? "–")")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)

            Text("\(format(schedule.entryDate)) - \(format(schedule.exitDate))")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color("PurpleStatus").opacity(0.8))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        .onTapGesture {
            showActions = true
        }
        .confirmationDialog("Concluir Pagamento", isPresented: $showActions) {
            if let onMarkAsPaid = onMarkAsPaid {
                Button(
                    payment.status == .pending ? "Marcar como pago" : "Marcar como pendente",
                    role: .none,
                    action: onMarkAsPaid
                )
            }

            Button("Cancelar", role: .cancel) {}
        }
    }
}
