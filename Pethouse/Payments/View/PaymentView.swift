//
//  PaymentView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftData
import SwiftUI

struct PaymentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedSegment = 0
    // @Query private var allPayments: [Payment]
    @Query private var allPaymentsRaw: [Payment]  // teste
    @State private var displayInfoList: [PaymentDisplayInfo] = []  // teste
    @State private var isPresentingForm = false  // teste

    //    var paymentsPending: [Payment] {
    //        allPayments.filter { $0.status == .pending }
    //    }
    //
    //    var paymentsPaid: [Payment] {
    //        allPayments.filter { $0.status == .paid }
    //    }

    var body: some View {
        let viewModel = PaymentViewModel(context: modelContext)

        NavigationView {
            VStack(spacing: 16) {
                Picker("Exibir", selection: $selectedSegment) {
                    Text("Pendentes").tag(0)
                    Text("Concluídos").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()

                ScrollView {
                    VStack(spacing: 24) {
                        if selectedSegment == 0 {
                            PaymentSection(
                                items: displayInfoList.filter {
                                    $0.payment.status == .pending
                                },
                                colorStatus: Color("YellowStatus"),
                                onMarkAsPaid: { payment in
                                    viewModel.togglePaymentStatus(payment)
                                },
                                onDelete: { payment in  //teste
                                    viewModel.delete(payment)
                                    displayInfoList.removeAll {
                                        $0.payment.id == payment.id
                                    }
                                }  // fim do teste
                            )
                        } else {
                            PaymentSection(
                                items: displayInfoList.filter {
                                    $0.payment.status == .paid
                                },
                                colorStatus: Color("GreenStatus"),
                                onMarkAsPaid: { payment in
                                    viewModel.togglePaymentStatus(payment)
                                },
                                onDelete: { payment in //teste
                                    viewModel.delete(payment)
                                    displayInfoList.removeAll {
                                        $0.payment.id == payment.id
                                    }// fim do teste
                                }
                            )
                        }
                    }
                }
            }
            .navigationTitle("Pagamentos")
            // teste
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingForm = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }  // teste
            .sheet(isPresented: $isPresentingForm) {
                PaymentFormView(displayList: $displayInfoList)
            }  //apenas para teste
        }
    }
}
#Preview {
    PaymentView()
}
