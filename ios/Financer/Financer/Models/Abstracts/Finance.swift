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
internal class Finance {

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
}
