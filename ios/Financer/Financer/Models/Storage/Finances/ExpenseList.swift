//
//  ExpenseList.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation

/// The List Model that contains all the Expenses.
internal final class ExpenseList : ModelsList<Expense>, Instancable {
    static internal private(set) var instance: ExpanseList = ExpanseList()
}
