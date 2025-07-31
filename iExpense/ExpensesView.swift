//
//  ContentView.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 14.07.2025.
//

import SwiftUI

struct ExpensesView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(ExpenseType.allCases, id: \.self) { expenseType in
                    Tab(expenseType.rawValue, systemImage: expenseType.iconName) {
                        ExpensesListView(
                            title: expenseType.rawValue,
                            expensesItems: expenses.items.filter {
                                $0.type == expenseType
                            },
                            onDelete: {
                                offset in removeItems(ofType: expenseType, at: offset)
                            }
                        )
                    }
                }
            }
            .toolbar {
                Button("Добавить расход", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .fullScreenCover(isPresented: $showingAddExpense) {
                AddView(expenses: $expenses)
            }
        }
    }
    
    func removeItems(ofType type: ExpenseType ,at offsets: IndexSet) {
        let filteredItemsWithIndices = expenses.items.enumerated().filter {
            $0.element.type == type
        }
        let indicesToDelete = offsets.map {
            filteredItemsWithIndices[$0].offset
        }
        for index in indicesToDelete.sorted(by: >) {
            expenses.items.remove(at: index)
        }
    }
}

#Preview {
    ExpensesView()
}
