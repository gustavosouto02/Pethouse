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
                                if let data = viewModel.pet.image, let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                } else {
                                    PhotoComponent()
                                }
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
                            
                            
                        }
                        Section(header: Text("Datas")) {
                            DatePicker(
                                "Data de entrada:",
                                selection: $viewModel.entryDate,
                                displayedComponents: .date
                            )
                            .padding(.vertical, 2)
                            
                            DatePicker(
                                "Data de saída:",
                                selection: $viewModel.exitDate,
                                in: Calendar.current.date(byAdding: .day, value: 1, to: viewModel.entryDate)!
                                    ...
                                    Calendar.current.date(byAdding: .year, value: 5, to: viewModel.entryDate)!,
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
                    viewModel.exitDate = scheduletoEdit.exitDate > scheduletoEdit.entryDate
                        ? scheduletoEdit.exitDate
                        : Calendar.current.date(byAdding: .day, value: 1, to: scheduletoEdit.entryDate) ?? scheduletoEdit.entryDate
                    viewModel.selectecCategory = scheduletoEdit.payment.method ?? .cash
                    opened = true
                }
            }

            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                    .foregroundStyle(.red)
                }
                
                ToolbarItem(placement: .confirmationAction) {
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
                    .disabled(viewModel.pet.name.isEmpty)
                    
                }
            }
        }
    }
}

#Preview {
    AddScheduleView()
}
