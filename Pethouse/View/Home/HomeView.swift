//
//  ContentView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
    @AppStorage("didInsertDefaultReflections") var didInsertDefaults = false
    @Environment(\.modelContext) var context
    @State var showCardView: Bool = false
    @State var scheduleEdtit: Schedule?
    
    @Query var schedules: [Schedule]
    
    var current: [Schedule] {
        viewModel.filterCurrentSchedules(from: schedules)
    }
    var future: [Schedule] {
        viewModel.filterFutureSchedules(from: schedules)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if !current.isEmpty {
                    Text("Estadias atuais")
                        .font(.headline)
                        .padding(.leading)
                        .padding(.top, 20)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(current) { schedule in
                                Button {
                                    showCardView = true
                                    scheduleEdtit = schedule
                                } label: {
                                    CardHomeView(schedule: schedule)
                                        .shadow(color: Color.gray.opacity(0.3), radius: 5)
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
                                CardHomeView(schedule: schedule)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 5)
                                    .padding(10)
                            }
                        }
                        .scrollTargetLayout()
                    }
                }


                Spacer()
            }
            .navigationTitle("PetHouse")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showAddSchedule = true
                    } label: {
                        AddScheduleButton()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddSchedule) {
                AddScheduleView()
            }
            .navigationDestination(item: $scheduleEdtit , destination: { schedule in
                AddScheduleView(scheduletoEdit: schedule)
            })
            .onAppear {
                viewModel.insertDefaultDataIfNeeded(context: context, didInsertDefaults: &didInsertDefaults)
            }
        }
    }
}

#Preview {
    HomeView()
}
