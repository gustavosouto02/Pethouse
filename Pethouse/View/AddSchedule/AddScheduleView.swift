//
//  AddScheduleView.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import SwiftData
import SwiftUI

struct AddScheduleView: View {
    
    @Environment(\.modelContext) var context
    @State var viewModel = AddScheduleViewModel()
    @Environment(\.dismiss) var dismiss
    @Query var pets: [Pet]
    @State private var opened = false
    
    @State var scheduletoEdit: Schedule?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: UIColor.systemGroupedBackground)
                    .ignoresSafeArea(edges: .all)
                VStack {
                    Form {
                        
                        Section{
                            HStack {
                                Spacer()
                                PhotoComponent()
                                Spacer()
                            }
                            .listRowInsets(.none)
                            .listRowBackground(Color.clear)
                        }
                        
                        Section(header: Text("Pet")) {
                            
                            Picker(
                                "Selecione o pet:",
                                selection: $viewModel.pet
                            ) {
                                ForEach(pets) { pet in
                                    Text(pet.name)
                                        .tag(pet)
                                    
                                }
                            }
                            .pickerStyle(.navigationLink)
                            
                            HStack {
                                Text("Pet não cadastrado?")
                                
                                Button {
                                    viewModel.showAddPetView = true
                                } label: {
                                    Text("Cadastre agora!")
                                    
                                }
                                .padding(.leading)
                                .foregroundColor(.accentColor)
                            }
                            
                        }
                        Section(header: Text("Datas")) {
                            DatePicker(
                                "Data de entrada:",
                                selection: $viewModel.entryDate,
                                displayedComponents: .date
                            )
                            .padding(.vertical, 2)
                            
                            DatePicker(
                                "Data de saida:",
                                selection: $viewModel.exitDate,
                                displayedComponents: .date
                            )
                            .padding(.vertical, 2)
                        }
                        
                        Section(header: Text("Pagamento")) {
                            Picker(
                                "Forma de pagamento:",
                                selection: $viewModel.selectecCategory
                            ) {
                                
                                ForEach(PaymentMethod.allCases) { method in
                                    Text(method.rawValue.capitalized)
                                        .tag(method)
                                }
                            }
                            
                        }
                        
                        Section(header: Text("Diaria:")) {
                            HStack {
                                Text("Valor da diaria:")
                                Spacer()
                                TextField(
                                    "Digite: ",
                                    value: $viewModel.dailyValue,
                                    formatter: viewModel.numberFormatter
                                )
                                .keyboardType(.numberPad)
                                //.textFieldStyle(.roundedBorder)
                                .frame(width: 100, height: 0)
                            }
                            HStack {
                                Text("Valor total:")
                                    .foregroundStyle(Color.accentColor)
                                Spacer()
                                Text(
                                    viewModel.totalValue,
                                    format: .currency(code: "BRL")
                                )
                                .frame(width: 140, height: 0)
                                .foregroundStyle(Color.accentColor)
                            }
                        }
                        
                        if let schedule = scheduletoEdit {
                            Section(header: Text("Excluir")) {
                                
                                HStack {
                                    Button(action: {
                                        viewModel.deleteSchedule(
                                            context: context,
                                            schedule: schedule
                                            
                                        )
                                        dismiss()
                                        
                                    }) {
                                        Text("Excluir estadia")
                                            .foregroundStyle(Color.red)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "trash")
                                        .foregroundStyle(Color.red)
                                }
                                
                            }
                        }
                    }
                    
                }
                
            }
            .onAppear {
                if let scheduletoEdit = scheduletoEdit, !opened {
                    viewModel.pet = scheduletoEdit.pet
                    viewModel.dailyValue = scheduletoEdit.dailyValue
                    viewModel.entryDate = scheduletoEdit.entryDate
                    viewModel.exitDate = scheduletoEdit.exitDate
                    viewModel.selectecCategory = scheduletoEdit.payment.method ?? .cash
                    opened = true
                }
            }
            .sheet(
                isPresented: $viewModel.showAddPetView,
                content: {
                    AddPetView()
                }
            )
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        if let scheduletoEdit = scheduletoEdit {
                            viewModel.updateSchedule(
                                context: context,
                                schedule: scheduletoEdit
                            )
                        } else {
                            viewModel.addSchedule(context: context)
                            
                        }
                        
                        dismiss()
                    } label: {
                        Text("Salvar")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    AddScheduleView()
}
