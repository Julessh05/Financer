//
//  LegalPerson.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// The class all Legal Persons extend from
internal class LegalPerson {

    /// The Name of this Legal Person
    internal let name : String

    internal enum Relation {
        
    }

    internal init(name : String) {
        self.name = name
    }
}
