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

    /// The Relation if this Legal Person is a Company
    @State private var companyRelation : LegalPerson.CompanyRelation = .customer

    /// The Relation if this Legal Person is a Person
    @State private var personRelation : LegalPerson.PersonRelation = .friend

    /// The Relation if this Legal Person is an Organization
    @State private var organizationRelation : LegalPerson.OrganizationRelation = .member

    /// The Homepage of this Legal Person
    @State private var homepage : String = ""

    /// The Phone Number of this Legal Person
    @State private var phone : String = ""

    /// Action to dismiss this View programmatically
    @Environment(\.dismiss) private var dismiss : DismissAction

    var body: some View {
        VStack {
            List {
                Section {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(5)
                } header: {
                    Text("General")
                } footer: {
                    Text("Data that all Legal Person have")
                }
                Section {
                    Picker("Type", selection: $legalPersonType) {
                        ForEach(LegalPerson.LegalPersonType.allCases) {
                            type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                } header: {
                    Text("Type")
                } footer: {
                    Text("The Type this Legal Person represents")
                }
                specificArea()
            }
            Button {
                addLegalPerson()
            } label: {
                legalPersonType != .none ?
                Label("Add \(legalPersonType.rawValue.capitalized)", systemImage: "plus") :
                Label("Not enough Data", systemImage: "xmark")
            }
        }
        .textFieldStyle(.plain)
        .pickerStyle(.automatic)
        .navigationTitle("Create Legal Person")
        .navigationBarTitleDisplayMode(.automatic)
    }

    /// Builds and renders the Area with the
    /// specific Details and Input Fields for this
    /// Type of Legal Person
    @ViewBuilder
    private func specificArea() -> some View {
        switch legalPersonType {
            case .company, .organization, .person:
                Section {
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
                } header: {
                    Text("Specific")
                } footer: {
                    Text("Specific Data depending on the Type of this Legal Person")
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
            .textInputAutocapitalization(.never)
    }

    /// Returns a Text Field to
    /// enter the Homepage
    /// URL in
    @ViewBuilder
    private func homepageField() -> some View {
        TextField("Homepage", text: $homepage)
            .textContentType(.URL)
            .keyboardType(.URL)
            .textInputAutocapitalization(.never)
    }

    /// Adds the Legal Person to
    /// the Legal Person List
    private func addLegalPerson() -> Void {
        // Prevents this Function to execute
        // the Statement listed in the default case
        guard legalPersonType != .none else {
            return
        }
        let person : LegalPerson
        switch legalPersonType {
            case .company:
                person = Company(
                    name: name,
                    relation: companyRelation,
                    phone: phone,
                    notes: notes,
                    homepage: URL(string: homepage)
                )
                break
            case .person:
                person = Person(
                    name: name,
                    relation: personRelation,
                    phone: phone,
                    notes: notes
                )
                break
            case .organization:
                person = Organization(
                    name: name,
                    relation: organizationRelation,
                    phone: phone,
                    notes: notes,
                    homepage: URL(string: homepage))
                break
            default:
                // Statement is just inserted
                // to satisfy compiler.
                // This case cannot happen.
                person = Person(
                    name: "Should not happen",
                    relation: .family,
                    phone: "0123456789",
                    notes: "If you see this Person, something went wrong. Please contact the Administrator."
                )
                break
        }
        LegalPersonList.instance.add(item: person)
        dismiss()
    }
}

struct CreateLegalPerson_Previews: PreviewProvider {
    static var previews: some View {
        CreateLegalPerson()
    }
}
