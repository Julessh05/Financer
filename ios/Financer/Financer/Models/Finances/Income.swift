//
//  Income.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// The Protocol that represents a single
/// Income of this User.
internal final class Income : Finance {

    init(amount: Finance.Money, legalPerson: LegalPerson) {
        super.init(amount: amount, legalPerson: legalPerson, type: .income)
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
