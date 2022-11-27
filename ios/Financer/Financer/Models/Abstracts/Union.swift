//
//  Union.swift
//  Financer
//
//  Created by Julian Schumacher on 16.11.22.
//

import Foundation

/// The class model all
/// unions must implement
internal class Union : LegalPerson {

    /// The Homepage to this Union
    internal let homepage : URL?

    internal init(
        name : String,
        relation : any Relation,
        phone : String,
        notes : String,
        homepage: URL?
    ) {
        self.homepage = homepage
        super.init(
            name: name,
            relation: relation,
            phone: phone,
            notes: notes
        )
    }
}
