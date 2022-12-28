//
//  LegalPersonListTile.swift
//  Financer
//
//  Created by Julian Schumacher as LegalPersonListTile.swift on 24.12.22.
//
// Renamed by Julian Schumacher to ListTile.swift on 24.12.22

import SwiftUI

/// The List TIle to represent Model  in a List
internal struct ListTile: View {
    
    /// The Legal Person for this View
    @State private var person : LegalPerson
        
    /// The callback to execute for Legal Persons
    private let callback : (LegalPerson) -> ()
    
    /// Initializer for a List Tile representing the specified Legal Person
    internal init(person: LegalPerson, _ callback : @escaping (LegalPerson) -> ()) {
        self._person = State(initialValue: person)
        self.callback = callback
    }
    
    /// Whether the Info View is active or not.
    @State private var viewActive : Bool = false
    var body: some View {
        HStack {
            HStack {
                Text(person.name ?? "Unknown")
                Spacer()
            }
            // Solution from: https://stackoverflow.com/questions/57191013/swiftui-cant-tap-in-spacer-of-hstack
            .contentShape(Rectangle())
            .onTapGesture {
                callback(person)
            }
            Button {
                viewActive.toggle()
            } label: {
                Image(systemName: "info.circle")
            }
            .sheet(isPresented: $viewActive) {
                LegalPersonDetails(legalPerson: $person)
            }
        }
    }
}

internal struct LegalPersonListTile_Previews: PreviewProvider {
    static var previews: some View {
        ListTile(
            person: LegalPerson.anonymous,
            { _ in print("Callback activated") }
        )
    }
}
