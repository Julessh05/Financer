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
    internal enum LegalPersonType : String, CaseIterable, Identifiable {
        var id : Self { self }

        /// This Legal Person is
        /// a Company
        case company

        /// This Legal Person is
        /// an Organization
        case organization

        /// This Legal Person is a person
        case person
    }

    init(legalPersonType : LegalPersonType) {
        _legalPersonType = State(
            initialValue: legalPersonType
        )
    }

    /// The Type of this Legal Person that is beeing added.
    @State private var legalPersonType : LegalPersonType

    /// The Name of the Legal Person
    @State private var name : String = ""

    /// The Notes to this Object
    @State private var notes : String = ""

    /// The Relation of this Legal Person to the User
    @State private var relation : (any Relation)?

    /// The Relation if this Legal Person is a Company
    @State private var companyRelation : LegalPerson.CompanyRelation?

    /// The Relation if this Legal Person is a Person
    @State private var personRelation : LegalPerson.PersonRelation?

    /// The Relation if this Legal Person is an Organization
    @State private var organizationRelation : LegalPerson.OrganizationRelation?

    /// The Homepage of this Legal Person
    @State private var homepage : String = ""

    /// The Phone Number of this Legal Person
    @State private var phone : String = ""

    var body: some View {
        VStack {
            List {
                Section("General") {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(5)
                }
                Section("Type") {
                    Picker("Type", selection: $legalPersonType) {
                        ForEach(LegalPersonType.allCases) {
                            type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                }
                specificArea()
            }
            Button {
                // TODO: add Action Code
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add \(legalPersonType.rawValue.capitalized)")
                }
            }
        }
        .textFieldStyle(.plain)
        .pickerStyle(.automatic)
        .navigationTitle("Add Finance")
        .navigationBarTitleDisplayMode(.automatic)
    }

    /// Builds and renders the Area with the
    /// specific Details and Input Fields for this
    /// Type of Legal Person
    @ViewBuilder
    private func specificArea() -> some View {
        switch legalPersonType {
            case .company, .organization, .person:
                Section("Specific") {
                    let pickerName : String = "Relation"
                    switch legalPersonType {
                        case .company:
                            Picker(pickerName, selection: $companyRelation) {
                                ForEach(LegalPerson.CompanyRelation.allCases) {
                                    relation in
                                    Text(relation.rawValue.capitalized)
                                }
                            }
                            homepageField()
                        case .organization:
                            Picker(pickerName, selection: $organizationRelation) {
                                ForEach(LegalPerson.OrganizationRelation.allCases) {
                                    relation in
                                    Text(relation.rawValue.capitalized)
                                }
                            }
                            homepageField()
                        case .person:
                            Picker(pickerName, selection: $personRelation) {
                                ForEach(LegalPerson.PersonRelation.allCases) {
                                    relation in
                                    Text(relation.rawValue.capitalized)
                                }
                            }
                    }
                    phoneNumberField()
                }
        }
    }

    /// Returns a Text Field
    /// to enter the phone Number in
    @ViewBuilder
    private func phoneNumberField() -> some View {
        TextField("Phone Number", text: $phone)
            .keyboardType(.phonePad)
            .textContentType(.telephoneNumber)
    }

    /// Returns a Text Field to
    /// enter the Homepage
    /// URL in
    @ViewBuilder
    private func homepageField() -> some View {
        TextField("Homepage", text: $homepage)
            .textContentType(.URL)
            .keyboardType(.URL)
    }
}

struct CreateLegalPerson_Previews: PreviewProvider {
    static var previews: some View {
        CreateLegalPerson(legalPersonType: .person)
    }
}
