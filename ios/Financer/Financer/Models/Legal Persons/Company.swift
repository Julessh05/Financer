//
//  Company.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// A single Company in this App.
internal final class Company : LegalPerson {

    /// The URL of the Homepage of this Company
    internal let homepage : URL?

    /// The Phone Number of this Company
    internal let phone : String

    /// Initializer with all Values
    internal init(
        name : String,
        relation : CompanyRelation,
        homepage: URL?,
        phone : String
    ) {
        self.homepage = homepage
        self.phone = phone
        super.init(name: name, relation : relation)
    }

    /// Initializer with all Values
    /// exept of the optional Phone Number
    internal init(
        name : String,
        relation : CompanyRelation,
        homepage: URL?
    ) {
        self.homepage = homepage
        self.phone = ""
        super.init(name: name, relation : relation)
    }
}
