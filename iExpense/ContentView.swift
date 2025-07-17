//
//  ContentView.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 14.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab(ExpenseType.business.rawValue, systemImage: "briefcase.fill") {
                    ExpensesListView(
                        title: ExpenseType.business.rawValue,
                        expenses: expenses.items.filter { $0.type == .business },
                        onDelete: { offset in removeItems(ofType: .business, at: offset) }
                    )
                }
                
                
                Tab(ExpenseType.personal.rawValue, systemImage: "person.fill") {
                    ExpensesListView(
                        title: ExpenseType.personal.rawValue,
                        expenses: expenses.items.filter { $0.type == .personal},
                        onDelete: { offset in removeItems(ofType: .personal, at: offset)}
                    )
                }
            }
            .toolbar {
                Button("Добавить расход", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(ofType type: ExpenseType ,at offsets: IndexSet) {
        let filteredItemsWithIndices = expenses.items.enumerated().filter { $0.element.type == type }
        let indicesToDelete = offsets.map { filteredItemsWithIndices[$0].offset }
        for index in indicesToDelete.sorted(by: >) {
            expenses.items.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
