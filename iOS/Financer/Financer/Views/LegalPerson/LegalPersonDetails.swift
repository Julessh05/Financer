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
    
    // Discussion on: https://developer.apple.com/forums/thread/663901
    // Solution here: https://developer.apple.com/forums/thread/663901?answerId=667633022#667633022
    @FetchRequest private var finances : FetchedResults<Finance>
    
    /// The Legal Parson beeing shown right here
    private var legalPerson : LegalPerson
    
    /// The Initializer with the Legal Person this Screen should be
    /// generated for.
    internal init(legalPerson: LegalPerson) {
        self.legalPerson = legalPerson
        _finances = FetchRequest(
            entity: Finance.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Finance.date, ascending: true)
            ],
            predicate: NSPredicate(format: "legalPerson == %@", legalPerson)
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    DefaultListTile(name: "Name", data: legalPerson.name!)
                    DefaultListTile(name: "Type", data: legalPerson.typeAsString)
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
                    ForEach(finances) {
                        finance in
                        NavigationLink(finance.typeAsString) {
                            FinanceDetails(finance: finance)
                        }
                    }
                } header: {
                    Text("Relations")
                } footer: {
                    Text("Represents all relations this Finance has.")
                }
            }
            .navigationTitle("\(legalPerson.name!) Details")
        }
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
}

internal struct LegalPersonDetails_Previews: PreviewProvider {
    
    /// The preview legal Person
    private static var person : LegalPerson = LegalPerson.anonymous
    
    static var previews: some View {
        LegalPersonDetails(legalPerson: person)
    }
}
