//
//  LegalPersonDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 26.11.22.
//

import SwiftUI

/// A View to represent a single Legal Person
internal struct LegalPersonDetails: View {

    /// The Legal Person beeing represented
    /// in this View
    internal let person : LegalPerson

    var body: some View {
        List {

        }.navigationTitle(person.name)
    }
}

struct LegalPersonDetails_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonDetails(
            person: Person(
                name: "Test",
                relation: .family,
                phone: "",
                notes: "This is just a Test Person"
            )
        )
    }
}
