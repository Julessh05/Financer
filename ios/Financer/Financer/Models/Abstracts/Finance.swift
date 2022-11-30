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
internal class Finance : Equatable, Codable, Identifiable {

    /// Enum to define the Type of the Finance
    internal enum FinanceType : String, Identifiable, CaseIterable {
        var id : Self { self }

        case income
        case expense
    }
    /// The Typealias for the Money
    /// used in those classes
    internal typealias Money = Double

    internal var id: UUID = UUID()

    /// The Amount of Money
    /// this Finance is linked to.
    internal let amount : Money

    /// The Legal Person this Finance is connected to
    internal let legalPerson : LegalPerson

    /// The Keys to encode and decode Finances
    private enum Keys : CodingKey {
        /// The Amount Attribute
        case amount

        /// The Legal Person Attribute
        case legalPerson

        /// The ID of this Object
        case id
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        amount = try container.decode(Money.self, forKey: .amount)
        legalPerson = try container.decode(LegalPerson.self, forKey: .legalPerson)
        id = try container.decode(UUID.self, forKey: .id)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(amount, forKey: .amount)
        try container.encode(legalPerson, forKey: .legalPerson)
    }

    internal init(amount : Money, legalPerson : LegalPerson) {
        self.amount = amount
        self.legalPerson = legalPerson
    }

    // Override to conform to Equatable
    static func == (lhs: Finance, rhs: Finance) -> Bool {
        return lhs.amount == rhs.amount && lhs.legalPerson == rhs.legalPerson
    }
}
