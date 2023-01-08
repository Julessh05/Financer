//
//  LegalPersonListTile.swift
//  Financer
//
//  Created by Julian Schumacher as LegalPersonListTile.swift on 24.12.22.
//
//  Renamed by Julian Schumacher to ListTile.swift on 24.12.22
//
//  Renamed back by Julian Schumacher to LegalPersonListTile.swift on 08.01.23
//

import SwiftUI

/// The List TIle to represent Model  in a List
internal struct LegalPersonListTile: View {
    
    /// The Wrapper of the legal Person being presented
    @EnvironmentObject private var legalPersonWrapper : LegalPersonWrapper
    
    /// The Legal Person for this View
    private let person : LegalPerson
    
    /// The callback to execute for Legal Persons
    private let callback : (LegalPerson) -> ()
    
    /// Initializer for a List Tile representing the specified Legal Person
    internal init(person: LegalPerson, _ callback : @escaping (LegalPerson) -> ()) {
        self.person = person
        self.callback = callback
    }
    
    /// Whether the Info View is active or not.
    @State private var viewActive : Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Text(person.name ?? "Deleted Person")
                Spacer()
            }
            // Solution from: https://stackoverflow.com/questions/57191013/swiftui-cant-tap-in-spacer-of-hstack
            .contentShape(Rectangle())
            .onTapGesture {
                callback(person)
            }
            Button {
                legalPersonWrapper.legalPerson = person
                viewActive.toggle()
            } label: {
                Image(systemName: "info.circle")
            }
            .sheet(isPresented: $viewActive) {
                LegalPersonDetails()
                    .environmentObject(legalPersonWrapper)
            }
        }
    }
}

internal struct LegalPersonListTile_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonListTile(
            person: LegalPerson.anonymous,
            { _ in print("Callback activated") }
        )
    }
}
