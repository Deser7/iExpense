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
    @State private var title = "Новый расход"
    @State private var showingAlert = false
    
    @Binding var expenses: Expenses
    
    let types = ExpenseType.allCases
    
    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Название", text: $title)
                    .onChange(of: title) { oldValue, newValue in
                        name = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                
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
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Назад") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Сохранить") {
                        saveExpence()
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("Ошибка", isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text("Пожалуйста, введите название расхода")
            }
        }
    }
    
    private func saveExpence() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty {
            showingAlert = true
            return
        }
        
        let item = ExpenseItem(
            name: trimmedName,
            type: type,
            amount: amount
        )
        expenses.items.append(item)
        dismiss()
    }
}

#Preview {
    AddView(expenses: .constant(Expenses()))
}
