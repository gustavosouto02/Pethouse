//
//  ContentView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {

    @State var viewModel = HomeViewModel()
    @AppStorage("didInsertDefaultReflections") var didInsertDefaults = false
    @Environment(\.modelContext) var context
    @State var scheduleEdtit: Schedule?
    @State private var presentScheduleView = false

    @Query var schedules: [Schedule]

    var current: [Schedule] {
        viewModel.filterCurrentSchedules(from: schedules)
    }
    var future: [Schedule] {
        viewModel.filterFutureSchedules(from: schedules)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if current.isEmpty && future.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray.opacity(0.4))

                            Text("Nenhuma estadia cadastrada")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)

                            Text(
                                "Toque no botão '+' acima para adicionar uma nova estadia."
                            )
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 280)
                        .padding()
                    }else{
                        if !current.isEmpty {
                            Text("Estadias atuais")
                                .font(.headline)
                                .padding(.leading)
                                .padding(.top, 20)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(current) { schedule in
                                        Button {
                                            presentScheduleView = true
                                            scheduleEdtit = schedule
                                        } label: {
                                            CardHomeView(schedule: schedule)
                                                .shadow(
                                                    color: Color.gray.opacity(0.3),
                                                    radius: 5
                                                )
                                                .padding(10)
                                        }
                                    }
                                }
                                .scrollTargetLayout()
                                .padding(.bottom, 20)
                            }
                        }
                        if !future.isEmpty {
                            Text("Estadias futuras")
                                .font(.headline)
                                .padding(.leading)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(future) { schedule in
                                        Button {
                                            presentScheduleView = true
                                            scheduleEdtit = schedule
                                        } label: {
                                            CardHomeView(schedule: schedule)
                                                .shadow(
                                                    color: Color.gray.opacity(0.3),
                                                    radius: 5
                                                )
                                                .padding(10)
                                        }
                                    }
                                }
                                .scrollTargetLayout()
                            }
                        }
                    }
                    
                    

                    Spacer()
                    Text("Calendario")
                        .font(.headline)
                        .padding(.leading)
                        .padding(.top, 20)
                    CalendarScheduleView()
                        .padding(.horizontal, 30)
                        .padding(.top, 15)
                }
            }
            .navigationTitle("PetHouse")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presentScheduleView = true
                    } label: {
                        AddScheduleButton()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddSchedule) {
                AddScheduleView()
            }
            .onAppear {
                viewModel.insertDefaultDataIfNeeded(
                    context: context,
                    didInsertDefaults: &didInsertDefaults
                )
            }
            .sheet(isPresented: $presentScheduleView) {
                AddScheduleView(scheduletoEdit: scheduleEdtit)
            }
        }
    }
}

#Preview {
    HomeView()
}
