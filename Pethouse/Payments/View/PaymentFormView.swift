//
//  PaymentFormView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftUI
import SwiftData

struct PaymentFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var amount: String = ""
    @State private var status: PaymentStatus = .pending
    @State private var method: PaymentMethod = .card
    @State private var petName: String = ""
    @State private var tutorName: String = ""
    @Binding var displayList: [PaymentDisplayInfo]

    var paymentToEdit: Payment?

    var isEditMode: Bool {
        paymentToEdit != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Informações do Pet") {
                    TextField("Nome do Pet", text: $petName)
                    TextField("Nome do Tutor", text: $tutorName)
                }

                Section("Valor") {
                    TextField("R$ 0,00", text: $amount)
                        .keyboardType(.decimalPad)
                }

                Section("Status") {
                    Picker("Status", selection: $status) {
                        ForEach(PaymentStatus.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Método") {
                    Picker("Método de pagamento", selection: $method) {
                        ForEach(PaymentMethod.allCases) { method in
                            Text(method.rawValue).tag(method)
                        }
                    }
                }

                
                Section {
                    Button(isEditMode ? "Salvar alterações" : "Criar pagamento") {
                        savePayment()
                    }
                    .disabled(!isValid)
                }
            }
            .navigationTitle(isEditMode ? "Editar Pagamento" : "Novo Pagamento")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let payment = paymentToEdit {
                    amount = String(format: "%.2f", payment.amount)
                    status = payment.status
                    method = payment.method ?? .card
                }
            }
        }
    }

    var isValid: Bool {
        Double(amount.replacingOccurrences(of: ",", with: ".")) != nil && !petName.isEmpty && !tutorName.isEmpty
    }

    func savePayment() {
        guard let value = Double(amount.replacingOccurrences(of: ",", with: ".")) else { return }

        let payment = paymentToEdit ?? Payment(amount: value)
        payment.amount = value
        payment.status = status
        payment.method = method

        // Só insere se for novo
        if paymentToEdit == nil {
            modelContext.insert(payment)
        }

        try? modelContext.save()

        if !isEditMode {
            let info = PaymentDisplayInfo(payment: payment, petName: petName, tutorName: tutorName)
            displayList.append(info)
        } else {
            // Atualizar displayList se for edição
            if let index = displayList.firstIndex(where: { $0.payment.id == payment.id }) {
                displayList[index].petName = petName
                displayList[index].tutorName = tutorName
            }
        }

        dismiss()
    }


}

