//
//  Person.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// A single Person this User
/// has financial Internactions with.
internal final class Person : LegalPerson {

    internal override init(
        name: String,
        relation: PersonRelation,
        phone: String,
        notes: String
    ) {
        super.init(
            name: name,
            relation: relation,
            phone: phone,
            notes: notes
        )
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

