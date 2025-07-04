//
//  CalendarioView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 03/07/25.
//

import SwiftUI

struct CalendarioView: View {
    @Binding var dataSelecionada: Date
    let temRegistro: (Date) -> Bool
    @Environment(\.calendar) private var calendar
    @State private var mostrarSeletorData = false

    private var currentMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: dataSelecionada)
        return calendar.date(from: components) ?? dataSelecionada
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM 'de' yyyy"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: currentMonth).lowercased()
    }

    private var daysInMonth: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
              let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1) else {
            return []
        }

        let range = DateInterval(start: firstWeek.start, end: lastWeek.end)
        return calendar.generateDates(
            inside: range,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    private var weekDays: [String] {
        ["DOM.", "SEG.", "TER.", "QUA.", "QUI.", "SEX.", "SÁB."]
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    mostrarSeletorData = true
                } label: {
                    HStack {
                        Text(monthYearString)
                            .font(.callout)
                            .foregroundColor(.primary)
                        Image(systemName: "chevron.down")
                            .font(.caption)
                            .foregroundColor(Color("PurpleStatus"))
                    }
                }
                .sheet(isPresented: $mostrarSeletorData) {
                    NavigationView {
                        VStack {
                            DatePicker(
                                "",
                                selection: $dataSelecionada,
                                in: ...Date(),
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .padding()
                            .environment(\.locale, Locale(identifier: "pt_BR"))
                        }
                        .navigationTitle("Selecionar Data")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancelar") {
                                    mostrarSeletorData = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("OK") {
                                    mostrarSeletorData = false
                                }
                            }
                        }
                    }
                    .presentationDetents([.height(350)])
                }

                Spacer()

                HStack(spacing: 32) {
                    Button(action: { moveMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }

                    Button(action: { moveMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                }
            }
            .padding(.horizontal, 8)

            HStack(spacing: 0) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 8)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7), spacing: 4) {
                ForEach(daysInMonth, id: \.self) { date in
                    if calendar.isDate(date, equalTo: currentMonth, toGranularity: .month) {
                        let day = calendar.component(.day, from: date)
                        let isSelected = calendar.isDate(date, equalTo: dataSelecionada, toGranularity: .day)
                        let isToday = calendar.isDateInToday(date)
                        let isFuture = date > Date()
                        let hasStay = temRegistro(date)

                        Button {
                            if !isFuture  || hasStay {
                                dataSelecionada = date
                            }
                        } label: {
                            Text("\(day)")
                                .font(.footnote)
                                .frame(height: 32)
                                .frame(maxWidth: .infinity)
                                .background(isSelected ? Color.blue : Color.clear)
                                .foregroundColor(isFuture ? .gray : (isSelected ? .white : .primary))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(isToday ? Color.blue : Color.clear, lineWidth: 1)
                                )
                                .overlay(
                                    Group {
                                        if hasStay {
                                            Circle()
                                                .fill(isSelected ? .white : .blue)
                                                .frame(width: 4, height: 4)
                                                .offset(y: -4)
                                        }
                                    },
                                    alignment: .bottom
                                )
                        }
                    } else {
                        Text("")
                            .frame(height: 32)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 8)
    }

    private func moveMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            dataSelecionada = newDate
        }
    }
}

private extension Calendar {
    func isDate(_ date: Date, inBetween start: Date, and end: Date) -> Bool {
        (start...end).contains(date)
    }

    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        var current = interval.start

        while current < interval.end {
            if let next = nextDate(after: current, matching: components, matchingPolicy: .nextTime) {
                if next < interval.end {
                    dates.append(next)
                    current = next
                } else {
                    break
                }
            } else {
                break
            }
        }

        return dates
    }
}

