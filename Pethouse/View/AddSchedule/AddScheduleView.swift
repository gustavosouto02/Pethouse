//
//  AddScheduleView.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import SwiftUI

struct AddScheduleView: View {
    
    @State var viewModel = AddScheduleViewModel()
    
        
    var body: some View {
        NavigationStack {
            ZStack{
                Color(uiColor: UIColor.systemGroupedBackground)
                    .ignoresSafeArea(edges: .all)
                VStack {
 
                    PhotoComponent()

                    Spacer()
                    
                    
                    Form {
                        
                        Section(header: Text("Pet")) {
                            
                            Picker("Selecione o pet:", selection: $viewModel.pet) {
                                ForEach(viewModel.mockPets) { pet in
                                    Text(pet.name)
                                        .tag(pet)

                                }
                            }
                            .pickerStyle(.navigationLink)
                            
                            HStack{
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
                            DatePicker("Data de entrada:", selection: $viewModel.entryDate , displayedComponents: .date)
                                .padding(.vertical, 2)

                            DatePicker("Data de saida:", selection: $viewModel.exitDate , displayedComponents: .date)
                                .padding(.vertical, 2)
                        }
                        
                        Section(header: Text("Pagamento")) {
                            Picker("Forma de pagamento:", selection: $viewModel.selectecCategory) {
                                ForEach(PaymentMethod.allCases) { method in
                                    Text(method.rawValue.capitalized)
                                        .tag(method)
                                }
                            }
                            
                            //.padding(.bottom, 10)
                            
                            
                        }
                        
                        Section(header: Text("Diaria:")) {
                            HStack{
                                Text("Valor da diaria:")
                                Spacer()
                                TextField("Digite: ", value: $viewModel.dailyValue, formatter: viewModel.numberFormatter)
                                    .keyboardType(.numberPad)
                                    //.textFieldStyle(.roundedBorder)
                                    .frame(width: 100, height: 0)
                            }
                            HStack{
                                Text("Valor total:")
                                    .foregroundStyle(Color.accentColor)
                                Spacer()
                                Text (viewModel.totalValue, format: .currency(code: "BRL"))
                                    .frame(width: 140, height: 0)
                                    .foregroundStyle(Color.accentColor)


                            }

           
                            
                        }

                    }
                    //.scrollContentBackground(.hidden)
                    
                }

            }
            .sheet(isPresented: $viewModel.showAddPetView, content: {
                AddPetView()
            })
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        
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
