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

    @State private var list : ModelsList = PersonList()

    var body: some View {
        VStack {
            Picker("Type", selection: $lPT) {
                ForEach(LegalPerson.LegalPersonType.allCases) { person in
                    Text(person.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)

            List(list.items) {
                legalPerson in
                Text(legalPerson.name)
            }
        }
        .navigationTitle("Legal Person Picker")
        .navigationBarTitleDisplayMode(.automatic)
    }

    private func currentList() {
        return ModelsList.list<ModelsList.listType(for: lPT)>()
    }
}

struct LegalPersonPicker_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonPicker()
    }
}
