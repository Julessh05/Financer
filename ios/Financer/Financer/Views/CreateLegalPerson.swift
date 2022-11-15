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
    private enum LegalPersonType : String, CaseIterable, Identifiable {
        var id: Self { self }

        /// No Value given
        case none

        /// This Legal Person is
        /// a Company
        case company

        /// This Legal Person is
        /// an Organization
        case organization

        /// This Legal Person is a person
        case person
    }

    /// The Type of this Legal Person that is beeing added.
    @State private var type : LegalPersonType = .none

    /// The Name of the Legal Person
    @State private var name : String = ""

    /// The Notes to this Object
    @State private var notes : String = ""

    @State private var relation : any Relation = LegalPerson.CompanyRelation.employee

    var body: some View {
        List {
            Section("General") {
                TextField("Name", text: $name)
                TextField("Notes", text: $notes, axis: .vertical)
                    .lineLimit(5)
            }
            Section("Type") {
                Picker("Type", selection: $type) {
                    ForEach(LegalPersonType.allCases) {
                        type in
                        Text(type.rawValue.capitalized)
                    }
                }.pickerStyle(.automatic)
            }
            specificArea()
        }
        .textFieldStyle(.plain)
        .navigationTitle("Add Finance")
        .navigationBarTitleDisplayMode(.automatic)
    }
    
    @ViewBuilder
    private func specificArea() -> some View {

    }
}

struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        CreateLegalPerson()
    }
}
