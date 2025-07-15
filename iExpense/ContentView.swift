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
            List {
                ForEach(expenses.items) { item in
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
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Мои расходы")
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
    
    func setExpensesStyle(_ number: Double) -> Color {
        switch number {
        case 0..<1000: .green
        case 1000..<10000: .primary
        default: .red
        }
    }
}

#Preview {
    ContentView()
}
