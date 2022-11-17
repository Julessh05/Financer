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

    /// The Type of this Legal Person that is beeing added.
    @State private var legalPersonType : LegalPerson.LegalPersonType = .none

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
                        ForEach(LegalPerson.LegalPersonType.allCases) {
                            type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                }
                specificArea()
            }
            Button {
                // TODO: add Action Code
            } label: { btnLabel() }
        }
        .textFieldStyle(.plain)
        .pickerStyle(.automatic)
        .navigationTitle("Add Finance")
        .navigationBarTitleDisplayMode(.automatic)
    }

    /// Builds and returns the Label of the
    /// Button
    @ViewBuilder
    private func btnLabel() -> some View {
        if legalPersonType != .none {
            HStack {
                Image(systemName: "plus")
                Text("Add \(legalPersonType.rawValue.capitalized)")
            }
        } else {
            Text("Not enough Data")
        }
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
                        default:
                            EmptyView()
                    }
                    phoneNumberField()
                }
            default:
                EmptyView()
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
        CreateLegalPerson()
    }
}
