//
//  PaymentViewModel.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
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

    // Remover quando puxar dados da estadia
    func delete(_ payment: Payment) {
        context.delete(payment)
        try? context.save()
    }
}

// Dados extras apenas para visualização na UI
struct PaymentDisplayInfo: Identifiable {
    var id: UUID { payment.id }
    var payment: Payment
    var petName: String
    var tutorName: String
}

struct PaymentSection: View {
    var items: [PaymentDisplayInfo] // teste — será substituído por info vindo de Estadia
    var colorStatus: Color
    var onMarkAsPaid: ((Payment) -> Void)? = nil
    var onDelete: ((Payment) -> Void)? = nil // teste

    var body: some View {
        LazyVGrid(columns: [GridItem()], spacing: 16) {
            ForEach(items) { item in
                CardPayment(
                    info: item,
                    statusColor: colorStatus,
                    onMarkAsPaid: { onMarkAsPaid?(item.payment) },
                    onDelete: { onDelete?(item.payment) }// teste
                )
            }
        }
        .padding(.horizontal)
    }
}


struct CardPayment: View {
    var info: PaymentDisplayInfo // teste
    var statusColor: Color
    var onMarkAsPaid: (() -> Void)? = nil
    var onDelete: (() -> Void)? = nil // teste

    @State private var showActions = false

    var body: some View {
        let payment = info.payment

        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 20) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(info.tutorName) // teste
                        .font(.title3)
                        .lineLimit(1)

                    Text("Pet: \(info.petName)") // teste
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

            Text("21 de fev - 25 de fev") // teste
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
        .confirmationDialog(
            "Concluir Pagamento",
            isPresented: $showActions,
            titleVisibility: .visible
        ) {
            if let onMarkAsPaid = onMarkAsPaid {
                Button(
                    payment.status == .pending
                        ? "Marcar como pago" : "Marcar como pendente",
                    role: .none,
                    action: onMarkAsPaid
                )
            }

            if let onDelete = onDelete { // teste
                Button("Excluir", role: .destructive, action: onDelete)
            }

            Button("Cancelar", role: .cancel) {}
        }
    }
}
