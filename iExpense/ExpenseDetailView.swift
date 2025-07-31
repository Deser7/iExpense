//
//  ExpenseDetailView.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 31.07.2025.
//

import SwiftUI

struct ExpenseDetailView: View {
    let expenses = Expenses()
    let expense: ExpenseItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Название:")
                    .font(.headline)
                Spacer()
                Text(expense.name)
                    .font(.body)
            }
            
            HStack {
                Text("Тип:")
                    .font(.headline)
                Spacer()
                Text(expense.type.rawValue)
                    .font(.body)
            }
            
            HStack {
                Text("Сумма")
                    .font(.headline)
                Spacer()
                Text(
                    expense.amount,
                    format: .currency(code: expenses.currencyCode)
                )
                    .font(.title2)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Детали расходов")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExpenseDetailView(
        expense: ExpenseItem(
            name: "Пример расхода",
            type: .business,
            amount: 1500
        )
    )
}
