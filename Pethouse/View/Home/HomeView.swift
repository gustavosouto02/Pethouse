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
    
    @Query var schedules: [Schedule]
    
    var futureSchedules: [Schedule] {
        return schedules.filter { $0.entryDate > Date() }
    }
    var currentSchedules: [Schedule] {
        return schedules.filter { $0.entryDate <= Date() }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Estadias atuais")
                    .font(.headline)
                    .padding(.leading)
                    .padding(.top, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(currentSchedules) { schedule in
                            Button {
                                showCardView = true
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

                Text("Estadias futuras")
                    .font(.headline)
                    .padding(.leading)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(futureSchedules) { schedule in
                            CardHomeView(schedule: schedule)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5)
                                .padding(10)
                        }
                    }
                    .scrollTargetLayout()
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
            .navigationDestination(isPresented: $showCardView) {
                // TODO: colocar os atributos para quando abrir pelo showCardView ele mostrar os dados do card ja cadastrado
                AddScheduleView()
            }
            .onAppear {
                if !didInsertDefaults {
                    viewModel.mock.insertMockDataIfNeeded(context: context)
                    didInsertDefaults = true
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
