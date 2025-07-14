//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 14.07.2025.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
