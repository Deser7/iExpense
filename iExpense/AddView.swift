//
//  AddView.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 14.07.2025.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0
    
    @Binding var expenses: Expenses
    
    let types = ExpenseType.allCases
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Название", text: $name)
                
                Picker("Тип", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                
                TextField("Количество",
                          value: $amount,
                          format: .currency(code: expenses.currencyCode)
                )
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Новый расход")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Назад") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Сохранить") {
                        let item = ExpenseItem(
                            name: name,
                            type: type,
                            amount: amount
                        )
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: .constant(Expenses()))
}
