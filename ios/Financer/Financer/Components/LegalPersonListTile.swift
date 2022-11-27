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
    @State private var person : LegalPerson

    /// The callback to execute
    private let callback : () -> ()

    internal init(person: LegalPerson, _ callback : @escaping () -> ()) {
        self._person = State(initialValue: person)
        self.callback = callback
    }

    /// Whether the Info View is active or not.
    @State private var viewActive : Bool = false

    var body: some View {
        HStack {
            HStack {
                Text(person.name)
                Spacer()
            }
            // Solution from: https://stackoverflow.com/questions/57191013/swiftui-cant-tap-in-spacer-of-hstack
            .contentShape(Rectangle())
            .onTapGesture { callback() }
            Button {
                viewActive.toggle()
            } label: {
                Image(systemName: "info.circle")
            }.sheet(isPresented: $viewActive) {
                LegalPersonDetails(person: $person)
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
            ),
            { print("Callback activated") }
        )
    }
}
