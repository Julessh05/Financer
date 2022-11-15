//
//  Organization.swift
//  Financer
//
//  Created by Julian Schumacher on 15.11.22.
//

import Foundation

/// The class representing a single Organization in
/// this App
internal final class Organization : LegalPerson {
    init(name: String, relation: OrganizationRelation) {
        super.init(name: name, relation: relation)
    }
}
