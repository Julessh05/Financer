//
//  LegalPersonPicker.swift
//  Financer
//
//  Created by Julian Schumacher on 19.11.22.
//

import SwiftUI

/// View to pick a Legal Person
/// for your new Finance
internal struct LegalPersonPicker: View {

    /// The Type of the Legal Person
    /// the Picker currently shows
    @State private var lPT : LegalPerson.LegalPersonType = .none

    /// The Legal Person beeing picked
    @Binding internal var legalPerson : LegalPerson?

    /// The Action to dismiss this View programmatically
    @Environment(\.dismiss) private var dismiss : DismissAction

    var body: some View {
        VStack {
            Picker("Type", selection: $lPT) {
                ForEach(LegalPerson.LegalPersonType.allCases) { person in
                    Text(person.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)

            list()
            Spacer()
            NavigationLink(destination: CreateLegalPerson(type: lPT)) {
                Label("Add \(lPT != .none ? lPT.rawValue.capitalized : "Legal Person")", systemImage: "person.fill.badge.plus")
            }
        }
        // Done to refresh the View
        // when returning from creating a new Legal Person
        .onAppear(perform: {lPT = .none})
        .navigationTitle("Picker")
        .navigationBarTitleDisplayMode(.automatic)
    }

    /// Creates, chooses, renders and returns
    /// the List that is currently shown on the
    /// Picker Screen.
    @ViewBuilder
    private func list() -> some View {
        if lPT == .none {
            Spacer()
            Text("Choose a Type")
        } else if !Converter.list(for: lPT).isEmpty {
            List(Converter.list(for: lPT)) {
                item in
                LegalPersonListTile(person: item, {
                    legalPerson = item
                    dismiss()
                })
            }
        } else {
            Spacer()
            Label("No \(lPT.rawValue.capitalized) found", systemImage: "questionmark.folder")
        }
    }
}

struct LegalPersonPicker_Previews: PreviewProvider {
    @State static private var lp : LegalPerson?

    static var previews: some View {
        LegalPersonPicker(legalPerson: $lp)
    }
}
