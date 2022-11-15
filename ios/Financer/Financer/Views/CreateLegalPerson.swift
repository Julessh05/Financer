//
//  CreateLegalPerson.swift
//  Financer
//
//  Created by Julian Schumacher as AddFinance.swift on 15.11.22.
//  Renamed by Julian Schumacher to CreateLegalPerson.swift on 15.11.22.
//

import SwiftUI

/// View to create a new Legal Person
internal struct CreateLegalPerson: View {
    /// The Type of this Legal Person
    private enum LegalPersonType : String {
        /// This Legal Person is a person
        case person = "Person"

        /// This Legal Person is
        /// an Organization
        case organization = "Organization"

        /// This Legal Person is
        /// a Company
        case company = "Company"

        /// No Value given
        case none = "None"
    }
    /// The Type of this Legal Person that is beeing added.
    @State private var type : LegalPersonType = .none

    var body: some View {
        VStack {
            HStack {
                Menu("Type") {
                    Button("Company") {
                        type = .company
                    }
                    Button("Organization") {
                        type = .organization
                    }
                    Button("Person") {
                        type = .person
                    }
                }
                Spacer()
                Text(type.rawValue)
            }.padding(.horizontal, 12)
        }.navigationTitle("Add Finance")
            .navigationBarTitleDisplayMode(.automatic)
    }
}

struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        CreateLegalPerson()
    }
}
