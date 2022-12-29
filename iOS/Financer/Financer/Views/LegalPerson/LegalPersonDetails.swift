//
//  LegalPersonDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//

import SwiftUI

/// This View represents a Legal Person and shows all
/// it's details.
internal struct LegalPersonDetails: View {
    
    /// The Legal Parson beeing shown right here
    internal var legalPerson : LegalPerson
    
    var body: some View {
        VStack {
            List {
                Section {
                    DefaultListTile(name: "Name", data: legalPerson.name!)
                    DefaultListTile(name: "Type", data: typeLabel)
                } header: {
                    Text("General Values")
                } footer: {
                    Text("These are the general Values for this \(legalPerson.name!)")
                }
                Section {
                    DefaultListTile(name: "Phone", data: legalPerson.phone!)
                    Text(notes)
                        .lineLimit(5...10)
                        .foregroundColor(.gray)
                } header: {
                    Text("Optional Data")
                } footer: {
                    Text("These Data are optional and you may have not added them.")
                }
                Section {
                    
                } header: {
                    Text("Relations")
                } footer: {
                    Text("Represents all relations this Finance has.")
                }
            }
        }
        .navigationTitle("\(legalPerson.name!) Details")
    }
    
    /// Builds and returns the View representing
    /// the Homepage Field depending on
    /// the Type of the Legal Person
    @ViewBuilder
    private func homepageField() -> some View {
        if legalPerson is Union {
            let u : Union = legalPerson as! Union
            HStack {
                Text("Homepage")
                Spacer()
                if u.url != nil {
                    Link(u.url!.absoluteString, destination: u.url!)
                } else {
                    Text("No URL given")
                }
            }
        } else {
            EmptyView()
        }
    }
    
    /// The Notes shown in this View.
    /// If the Notes to this Legal Person are empty,
    /// this returns an information String
    /// stating exactly that.
    private var notes : String {
        if legalPerson.notes!.isEmpty {
            return "No Notes"
        } else {
            return legalPerson.notes!
        }
    }
    
    /// Returns the Type of the Legal Person
    /// as a String
    private var typeLabel : String {
        switch legalPerson {
            case is Person:
                return "Person"
            case is Company:
                return "Company"
            case is Organization:
                return "Organization"
            default:
                return "Unknown"
        }
    }
}

internal struct LegalPersonDetails_Previews: PreviewProvider {
    
    /// The preview legal Person
    private static var person : LegalPerson = LegalPerson.anonymous
    
    static var previews: some View {
        LegalPersonDetails(legalPerson: person)
    }
}
