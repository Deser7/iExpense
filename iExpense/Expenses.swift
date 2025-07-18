//
//  Expenses.swift
//  iExpense
//
//  Created by Наташа Спиридонова on 14.07.2025.
//

import Observation
import Foundation

@Observable
final class Expenses {
    
    let currencyCode = Locale.current.currency?.identifier ?? "RUB"
    
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoderItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decoderItems
                return
            }
        }
        items = []
    }
}
