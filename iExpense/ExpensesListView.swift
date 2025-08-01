//
//  ExpensesListView.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 16.07.2025.
//

import SwiftUI

struct ExpensesListView: View {
    let title: String
    let expensesItems: [ExpenseItem]
    let onDelete: (IndexSet) -> Void
    
    let expenses = Expenses()
    
    var body: some View {
        List {
            ForEach(expensesItems) { item in
                NavigationLink(destination: ExpenseDetailView(expense: item)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: expenses.currencyCode))
                            .foregroundStyle(setExpensesStyle(item.amount))
                    }
                }
            }
            .onDelete(perform: onDelete)
        }
        .navigationTitle(title)
    }
    
    func setExpensesStyle(_ number: Double) -> Color {
        switch number {
        case 0..<1000: .green
        case 1000..<10000: .primary
        default: .red
        }
    }
}

#Preview {
    ExpensesListView(
        title: "",
        expensesItems: [
            ExpenseItem(
                name: ExpenseType.business.rawValue,
                type: .business,
                amount: 100
            ),
            ExpenseItem(
                name: ExpenseType.personal.rawValue,
                type: .personal,
                amount: 200
            )
        ],
        onDelete: { _ in }
    )
}
