//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 14.07.2025.
//

import Foundation

// MARK: - ExpenseType
enum ExpenseType: String, CaseIterable, Codable {
    case business = "Бизнес"
    case personal = "Личные"
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    let type: ExpenseType
    let amount: Double
}
