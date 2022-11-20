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

    /// The current List that is used
    @State private var list : any ModelsListProtocol = PersonList()

    var body: some View {
        VStack {
            Picker("Type", selection: $lPT) {
                ForEach(LegalPerson.LegalPersonType.allCases) { person in
                    Text(person.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)
            ForEach(Converter.list(for: lPT).items) {
                item in
                Text(String())
            }
        }
        .navigationTitle("Legal Person Picker")
        .navigationBarTitleDisplayMode(.automatic)
    }

    private func currentList() -> Void {
        switch lPT {
            case .organization:
                list = OrganizationList()
                break
            case .company:
                list = CompanyList()
                break
            default:
                break
        }
    }
}

struct LegalPersonPicker_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonPicker()
    }
}
