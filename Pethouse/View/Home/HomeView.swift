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
							}
						}
					}
					.scrollTargetLayout()
					.padding(.bottom, 60)
					
				//}
	
				Group {
					Text("Estadias futuras")
						.font(.headline)
					ScrollView (.horizontal, showsIndicators: false) {
						HStack {
							ForEach(viewModel.schedules) { schedule in
								CardHomeView(schedule: schedule)
							}
						}
					}
					.scrollTargetLayout()
				}
				
				
            }
			.toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showAddSchedule = true
                    } label: {
                        AddScheduleButton()
                    }
                    
                }
            }
            .sheet(isPresented: $viewModel.showAddSchedule) {
                AddScheduleView()
                    .presentationDragIndicator(.visible)
            }
        }
	
        .padding()
    }
}

#Preview {
    HomeView()
}
