//
//  Company.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// A single Company in this App.
internal final class Company : Union {

    /// Initializer with all Values
    internal init(
        name : String,
        relation : CompanyRelation,
        homepage: URL?,
        phone : String,
        notes : String
    ) {
        super.init(
            name: name,
            relation: relation,
            phone: phone,
            notes: notes,
            homepage: homepage
        )
    }
}
