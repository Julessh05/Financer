//
//  LegalPersonListTile.swift
//  Financer
//
//  Created by Julian Schumacher on 26.11.22.
//

import SwiftUI

/// The List TIle to represent a single
/// Legal Person in a List
internal struct LegalPersonListTile: View {

    /// The Legal Person for this View
    internal let person : LegalPerson

    var body: some View {
        HStack {
            Text(person.name)
            Spacer()
            NavigationLink(destination: LegalPersonDetails(person: person)) {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct LegalPersonListTile_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonListTile(
            person: Person(
                name: "Test",
                relation: .family,
                phone: "",
                notes: "This is just a Test Person"
            )
        )
    }
}
