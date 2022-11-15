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

    internal init(amount : Money) {
        self.amount = amount
    }

    /// The Amount of Money
    /// this Finance is linked to.
    internal let amount : Money
}
