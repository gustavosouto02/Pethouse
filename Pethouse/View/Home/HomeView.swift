//
//  ContentView.swift
//  Pethouse
//
//  Created by Gustavo Souto Pereira on 02/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
	
	@State var tutor: [Tutor] = [
		Tutor(name: "Ana Silva", cpf: "123.456.789-00", phone: "(11) 98765-4321"),
		Tutor(name: "Bruno Costa", cpf: "987.654.321-00", phone: "(11) 91234-5678")
	]

	@State var pet: Pet
	@State var payment: Payment
	@State var schedules: [Schedule]

	init() {
		let mockTutors = [
			Tutor(name: "Ana Silva", cpf: "123.456.789-00", phone: "(11) 98765-4321"),
			Tutor(name: "Bruno Costa", cpf: "987.654.321-00", phone: "(11) 91234-5678")
		]

		// Initialize pet with the correctly formed tutor array
		_pet = State(initialValue: Pet(name: "Buddy", age: 3, breed: "Golden Retriever", specie: "Cão", gender: "Macho", tutors: mockTutors))
		
		let initialPayment = Payment(amount: 50.00)
		initialPayment.status = .paid
		initialPayment.method = .pix
		_payment = State(initialValue: initialPayment)

		let buddyPet = Pet(name: "Buddy", age: 3, breed: "Golden Retriever", specie: "Cão", gender: "Macho", tutors: mockTutors)
		let buddyPayment = Payment(amount: 50.00)
		buddyPayment.status = .paid
		buddyPayment.method = .pix

		let whiskersPet = Pet(name: "Whiskers", age: 2, breed: "Siamês", specie: "Gato", gender: "Fêmea", tutors: [
			Tutor(name: "Carlos Dias", cpf: "111.222.333-44", phone: "(21) 99887-7665")
		])
		let whiskersPayment = Payment(amount: 30.00)
		whiskersPayment.status = .paid
		whiskersPayment.method = .cash

		_schedules = State(initialValue: [
			Schedule(entryDate: Date(), exitDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, pet: buddyPet, payment: buddyPayment),
			Schedule(entryDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, exitDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, pet: whiskersPet, payment: whiskersPayment)
		])
	}

    var body: some View {
        NavigationStack {
			VStack(alignment: .leading) {
				Group {
					Text("Estadias atuais")
						.font(.headline)
					ScrollView (.horizontal, showsIndicators: false){
						HStack {
							ForEach(schedules) { schedule in
								CardHomeView(schedule: schedule)
							}
						}
					}
					.scrollTargetLayout()
					.padding(.bottom, 60)
					
				}
	
				Group {
					Text("Estadias futuras")
						.font(.headline)
					ScrollView (.horizontal, showsIndicators: false) {
						HStack {
							ForEach(schedules) { schedule in
								CardHomeView(schedule: schedule)
							}
						}
					}
					.scrollTargetLayout()
				}
				
				
            }
			.toolbar{
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.showAddSchedule = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .sheet(isPresented: $viewModel.showAddSchedule) {
                AddScheduleView()
            }
        }
	
        .padding()
    }
}

#Preview {
    HomeView()
}
