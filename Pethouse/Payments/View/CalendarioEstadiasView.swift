import SwiftUI

struct Estadia: Identifiable {
    var id = UUID()
    var entrada: Date
    var saida: Date
    var pet: String
}

struct CalendarioEstadiasView: View {
    @State private var dataSelecionada = Date()
    @State private var estadiaSelecionada: Estadia?
    @State private var mostrarDetalhes = false

    let estadiasMock: [Estadia] = [
        Estadia(
            entrada: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 2))!,
            saida: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 4))!,
            pet: "Pipoca"
        ),
        Estadia(
            entrada: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 10))!,
            saida: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 13))!,
            pet: "Thor"
        )
    ]

    var body: some View {
        CalendarioView(
            dataSelecionada: $dataSelecionada,
            temRegistro: { data in
                estadiasMock.contains { data >= $0.entrada && data <= $0.saida }
            }
        )
        .onChange(of: dataSelecionada) { _, novaData in
            if let estadia = estadiasMock.first(where: { $0.entrada <= novaData && novaData <= $0.saida }) {
                estadiaSelecionada = estadia
                mostrarDetalhes = true
            } else {
                estadiaSelecionada = nil
                mostrarDetalhes = false // <- garante que não abre sheet vazia
            }
        }
        .sheet(item: $estadiaSelecionada) { estadia in
            VStack(spacing: 24) {
                HStack {
                    Image(systemName: "pawprint.fill")
                        .foregroundColor(.purple)
                        .font(.title2)
                    Text("Detalhes da Estadia")
                        .font(.headline)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Label {
                        Text("Pet: \(estadia.pet)")
                            .font(.title3)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "dog.fill")
                            .foregroundColor(.blue)
                    }

                    Label {
                        Text("Entrada: \(estadia.entrada.formatted(date: .abbreviated, time: .omitted))")
                    } icon: {
                        Image(systemName: "calendar.badge.plus")
                            .foregroundColor(.green)
                    }

                    Label {
                        Text("Saída: \(estadia.saida.formatted(date: .abbreviated, time: .omitted))")
                    } icon: {
                        Image(systemName: "calendar.badge.minus")
                            .foregroundColor(.red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button("Fechar") {
                    estadiaSelecionada = nil // <- Isso fecha a sheet
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .presentationDetents([.medium])
        }

    }
}


#Preview {
    CalendarioEstadiasView()
}
