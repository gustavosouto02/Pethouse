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

    	

    var body: some View {
        NavigationStack {
			VStack(alignment: .leading) {
				//Group {
					Text("Estadias atuais")
						.font(.headline)
					ScrollView (.horizontal, showsIndicators: false){
						HStack {
                            ForEach(currentSchedules) { schedule in
                                CardHomeView(schedule: schedule)
                                    .shadow(color: Color.gray.opacity(0.3) ,radius: 5)
                                    .padding(10)
							}
						}
					}
					.scrollTargetLayout()
					.padding(.bottom, 20)
					
				//}
	
				Group {
					Text("Estadias futuras")
						.font(.headline)
					ScrollView (.horizontal, showsIndicators: false) {
						HStack {
							ForEach(futureSchedules) { schedule in
								CardHomeView(schedule: schedule)
                                    .shadow(color: Color.gray.opacity(0.3) ,radius: 5)

                                    .padding(10)

							}
						}
					}
					.scrollTargetLayout()
				}
                
                Spacer()
				
				
            }
            .onAppear(){
                if !didInsertDefaults {
                    viewModel.mock.insertMockDataIfNeeded(context: context)
                    didInsertDefaults = true
                }
            }
            .navigationTitle("PetHouse")
			.toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showAddSchedule = true
                    } label: {
                        AddScheduleButton()
                    }
                    
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddSchedule, destination: {
                AddScheduleView()

            })

        }
	
        //.padding()
    }
}

#Preview {
    HomeView()
}
