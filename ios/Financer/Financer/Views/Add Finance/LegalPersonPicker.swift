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
            NavigationLink(destination: CreateLegalPerson()) {
                Label("Add Legal Person", systemImage: "person.fill.badge.plus")
            }
        }
        // Done to refresh the View
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
            ForEach(Converter.list(for: lPT)) {
                item in
                Text(item.name)
            }
        } else {
            Spacer()
            Label("No \(lPT.rawValue.capitalized) found", systemImage: "questionmark.folder")
        }
    }
}

struct LegalPersonPicker_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonPicker()
    }
}
