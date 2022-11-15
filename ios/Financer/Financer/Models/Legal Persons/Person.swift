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

    
    init(name: String, relation: PersonRelation) {
        super.init(name: name, relation: relation)
    }
}


