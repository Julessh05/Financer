//
//  Company.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// A single Company in this App.
internal final class Company : LegalPerson {

    /// The Relation between this
    /// Company and the User
    internal enum Relation {
        /// The User is an Employee of this Company
        case employee

        /// The User is an external working Person
        /// that is arranged in this Company
        case externalWorker

        /// A Customer of this Company
        case customer

        /// A single Supplier of this Company.
        case supplier

        /// The CEO of this Company
        case ceo

        /// The User is a Share Holder of this Company.
        /// The Incomes and Expenses are dividents.
        case shareholder
    }

    /// The URL of the Homepage of this Company
    internal let homepage : URL

    /// The Relation between this App's User
    /// and the Company
    internal let relation : Relation

    /// Initializer with all Values
    internal init(name : String, homepage: URL, relation: Relation) {
        self.homepage = homepage
        self.relation = relation
        super.init(name: name)
    }
}
