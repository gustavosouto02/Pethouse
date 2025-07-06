//
//  CalendarScheduleView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 04/07/25.
//

import SwiftUI
import SwiftData

struct CalendarScheduleView: View {
    @Environment(\.modelContext) private var modelContext
        @Query private var schedules: [Schedule]
        @State private var selectedDate = Date()
    @State private var selectedSchedules: [Schedule] = []
    @Environment(\.calendar) private var calendar

    @State private var showDetails: Bool = false
    
    func updateSelectedSchedules() {
        let filtered = schedules.filter {
            calendar.isDate(selectedDate, inBetween: $0.entryDate, and: $0.exitDate)
        }

        selectedSchedules = filtered
    }

    var body: some View {
        CalendarView(
            selectedDate: $selectedDate,
            hasRegister: { data in
                schedules.contains { calendar.isDate(data, inBetween: $0.entryDate, and: $0.exitDate) }
            },
            onDateSelected: { newDate in
                let filtered = schedules.filter {
                    calendar.isDate(newDate, inBetween: $0.entryDate, and: $0.exitDate)
                }

                selectedSchedules = filtered
                showDetails = !filtered.isEmpty
            }
        )
        .overlay{
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.white)

                
                .shadow(radius: 8)
                .opacity(0.3)
        }

        
        .onChange(of: schedules) { _, _ in updateSelectedSchedules() }
        .onChange(of: selectedDate) { _, _ in updateSelectedSchedules() }
        .onAppear { updateSelectedSchedules() }
        .sheet(isPresented: $showDetails) {
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(selectedSchedules, id: \.id) { schedule in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "pawprint.fill")
                                        .foregroundColor(.purple)
                                        .font(.title2)
                                    Text("Detalhes da Estadia")
                                        .font(.headline)
                                }

                                Label {
                                    Text("Tutor: \(schedule.pet.tutors.first?.name ?? "Desconhecido")")
                                        .font(.subheadline)
                                } icon: {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.orange)
                                }

                                Label {
                                    Text("Pet: \(schedule.pet.name)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                } icon: {
                                    Image(systemName: "dog.fill")
                                        .foregroundColor(.blue)
                                }

                                Label {
                                    Text("Entrada: \(schedule.entryDate.formatted(date: .abbreviated, time: .omitted))")
                                } icon: {
                                    Image(systemName: "calendar.badge.plus")
                                        .foregroundColor(.green)
                                }

                                Label {
                                    Text("Saída: \(schedule.exitDate.formatted(date: .abbreviated, time: .omitted))")
                                } icon: {
                                    Image(systemName: "calendar.badge.minus")
                                        .foregroundColor(.red)
                                }

                                Divider()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                        }

                        Button("Fechar") {
                            showDetails = false
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
                .presentationDetents([.large])
            }
        }

    }

#Preview {
    CalendarScheduleView()
}

