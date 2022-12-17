//
//  Expense.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// The Struct that represents a single
/// Expense of the User
internal final class Expense : Finance {

    init(amount: Finance.Money, legalPerson: LegalPerson) {
        super.init(amount: amount, legalPerson: legalPerson, type: .expense)
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
