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
    
    /// The Wrapper of the Legal Person the User chose to see the Details
    /// from
    @StateObject private var legalPersonWrapper : LegalPersonWrapper = LegalPersonWrapper()
    
    /// The Legal Person for this View
    private var person : LegalPerson
        
    /// The callback to execute for Legal Persons
    private let callback : (LegalPerson) -> ()
    
    /// Initializer for a List Tile representing the specified Legal Person
    internal init(person: LegalPerson, _ callback : @escaping (LegalPerson) -> ()) {
        self.person = person
        self.callback = callback
        legalPersonWrapper.legalPerson = person
    }
    
    /// Whether the Info View is active or not.
    @State private var viewActive : Bool = false
    var body: some View {
        HStack {
            HStack {
                Text(person.name!)
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
                LegalPersonDetails()
                    .environmentObject(legalPersonWrapper)
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
