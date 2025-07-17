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
                        onDelete: removeItems
                    )
                }
                
                
                Tab(ExpenseType.personal.rawValue, systemImage: "person.fill") {
                    ExpensesListView(
                        title: ExpenseType.personal.rawValue,
                        expenses: expenses.items.filter { $0.type == .personal},
                        onDelete: removeItems
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
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
