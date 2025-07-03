//
//  AddScheduleView.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 02/07/25.
//

import SwiftUI

struct AddScheduleView: View {
    
    @State var viewModel = AddScheduleViewModel()
    

    fileprivate func logoView() -> some View {
        Circle()
            //.foregroundStyle(Color(uiColor: UIColor.systemGroupedBackground))
            .frame(width: 150, height: 150)
            .foregroundStyle(.white)
            .overlay(content: {
              Image(systemName: "photo.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .foregroundColor(Color.accentColor)
            })
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(uiColor: UIColor.systemGroupedBackground)
                    .ignoresSafeArea(edges: .all)
                VStack {
 
                    logoView()
                    
                    Spacer()
                    
                    Form {
                        Section(header: Text("Datas")) {
                            DatePicker("Data de entrada:", selection: $viewModel.entryDate , displayedComponents: .date)
                                .padding(.bottom, 10)

                            DatePicker("Data de saida:", selection: $viewModel.exitDate , displayedComponents: .date)
                                .padding(.bottom, 10)
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
