import SwiftUI
import SwiftData

struct PaymentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allSchedules: [Schedule]
    @State private var selectedSegment = 0

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
                        let filteredSchedules = allSchedules.filter {
                            selectedSegment == 0
                                ? $0.payment.status == .pending
                                : $0.payment.status == .paid
                        }

                        PaymentSection(
                            items: filteredSchedules,
                            colorStatus: selectedSegment == 0
                                ? Color("YellowStatus")
                                : Color("GreenStatus"),
                            onMarkAsPaid: viewModel.togglePaymentStatus
                        )
                    }
                    .padding(.bottom, 16)
                }
            }
            .navigationTitle("Pagamentos")
        }
    }
}

func format(_ date: Date) -> String {
    date.formatted(date: .abbreviated, time: .omitted)
}
