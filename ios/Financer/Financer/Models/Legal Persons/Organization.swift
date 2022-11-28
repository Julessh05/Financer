//
//  Organization.swift
//  Financer
//
//  Created by Julian Schumacher on 15.11.22.
//

import Foundation

/// The class representing a single Organization in
/// this App
internal final class Organization : Union {
    
    init(
        name: String,
        relation: OrganizationRelation,
        phone : String,
        notes : String,
        homepage : URL?
    ) {
        super.init(
            name: name,
            relation: relation,
            phone: phone,
            notes: notes,
            homepage: homepage
        )
    }

    required init(from decoder: Decoder) throws {
        super.init(from: decoder)
    }
}
