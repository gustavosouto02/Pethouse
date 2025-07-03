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
    
    @Query var schedules: [Schedule]
    
    var futureSchedules: [Schedule] {
        return schedules.filter { $0.entryDate > Date() }
    }
    var currentSchedules: [Schedule] {
        return schedules.filter { $0.entryDate <= Date() }
    }

	@State var showCardView = false
    var body: some View {
        NavigationStack {
			VStack(alignment: .leading) {
					Text("Estadias atuais")
						.font(.headline)
					ScrollView (.horizontal, showsIndicators: false){
				Text("Estadias atuais")
					.font(.headline)
					.padding(.leading)
					.padding(.top, 20)
				ScrollView (.horizontal, showsIndicators: false){
					HStack {
						ForEach(currentSchedules) { schedule in
							Button {
								showCardView = true
							} label: {
								CardHomeView(schedule: schedule)
									.shadow(color: Color.gray.opacity(0.3) ,radius: 5)
									.padding(10)
							}
						}
					}
				}
				.scrollTargetLayout()
				.padding(.bottom, 20)

				Text("Estadias futuras")
					.font(.headline)
					.padding(.leading)
				ScrollView (.horizontal, showsIndicators: false) {
					HStack {
						ForEach(futureSchedules) { schedule in
							Button {
								showCardView = true
							} label: {
								CardHomeView(schedule: schedule)
									.shadow(color: Color.gray.opacity(0.3) ,radius: 5)
									.padding(10)
							}
						}
					}
				}
				.scrollTargetLayout()
			
			Spacer()
			
            }
            .navigationTitle("PetHouse")
            .onAppear(){
                if !didInsertDefaults {
                    viewModel.mock.insertMockDataIfNeeded(context: context)
                    didInsertDefaults = true
                }
            }
                    }
                    
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddSchedule, destination: {
                AddScheduleView()
            })
	
			.navigationDestination(isPresented: $showCardView, destination: {
				//TODO: colocar os atributos para quando abrir pelo showCardView ele mostrar os dados do card ja cadastrado
				AddScheduleView()
			})
        }
	}

	
        //.padding()
    }
