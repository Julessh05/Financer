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
            ForEach(Converter.list(for: lPT)) {
                item in
                Text(item.name)
            }
        }
        .navigationTitle("Legal Person Picker")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct LegalPersonPicker_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonPicker()
    }
}
