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
    @State internal var person : LegalPerson

    var body: some View {
        NavigationStack {
            List {
                ListTile(title: "Name", data: person.name)
                ListTile(title: "Notes", data: person.notes)
                ListTile(title: "Relation", data: person.relation.rawValue)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: CreateLegalPerson(legalPerson: $person)) {
                        Image(systemName: "pencil")
                    }
                }
            }
            .toolbar(.visible, for: .navigationBar)
            .navigationTitle(person.name)
        }
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
