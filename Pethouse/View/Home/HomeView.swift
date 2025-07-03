//
//  ContentView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftUI

struct HomeView: View {
    
     @State var viewModel = HomeViewModel()
    	

    var body: some View {
        NavigationStack {
			VStack(alignment: .leading) {
				//Group {
					Text("Estadias atuais")
						.font(.headline)
					ScrollView (.horizontal, showsIndicators: false){
						HStack {
                            ForEach(viewModel.schedules) { schedule in
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
							ForEach(viewModel.schedules) { schedule in
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
