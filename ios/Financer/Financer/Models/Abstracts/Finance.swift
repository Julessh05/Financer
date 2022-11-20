//
//  Finance.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// The class all
/// Finance Objects have to confirm
/// to.
internal class Finance : Equatable {

    /// Enum to define the Type of the Finance
    internal enum FinanceType : String, Identifiable, CaseIterable {
        var id : Self { self }

        case income
        case expense
    }
    /// The Typealias for the Money
    /// used in those classes
    internal typealias Money = Double

    /// The Amount of Money
    /// this Finance is linked to.
    internal let amount : Money

    /// The Legal Person this Finance is connected to
    internal let legalPerson : LegalPerson

    internal init(amount : Money, legalPerson : LegalPerson) {
        self.amount = amount
        self.legalPerson = legalPerson
    }

    // Override to conform to Equatable
    static func == (lhs: Finance, rhs: Finance) -> Bool {
        return lhs.amount == rhs.amount && lhs.legalPerson == rhs.legalPerson
    }
}
