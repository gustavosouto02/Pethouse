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
            VStack {
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.gray.opacity(1))
                
                Spacer()
                
                Form {
                    Section(header: Text("Datas")) {
                        DatePicker("Data de Entrada:", selection: $viewModel.entryDate , displayedComponents: .date)
                            .padding(.bottom, 10)

                        DatePicker("Data de Saida:", selection: $viewModel.entryDate , displayedComponents: .date)
                            .padding(.bottom, 10)
                    }
                    
                    Section(header: Text("Pagamento")) {
                        Picker("Forma de pagamento:", selection: $viewModel.selectecCategory) {
                            ForEach(PaymentMethod.allCases) { method in
                                Text(method.rawValue.capitalized)
                                    .tag(method)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        
                    }

                }
                .scrollContentBackground(.hidden)
                
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
