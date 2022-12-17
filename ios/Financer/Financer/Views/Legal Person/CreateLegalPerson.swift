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

    /// Whether the Button is active or not
    @State private var btnActive : Bool = false

    /// Action to dismiss this View programmatically
    @Environment(\.dismiss) private var dismiss : DismissAction

    /// The Person beeing edited, if this Screen is in edit Mode
    private var legalPerson : Binding<LegalPerson>?

    /// Whether this Screen is in edit Mode or not.
    private let edit : Bool

    /// Initializer used to create a new Legal Person
    internal init(type: LegalPerson.LegalPersonType = .none) {
        edit = false
        legalPerson = nil
        _legalPersonType = State(initialValue: type)
    }

    /// Initializer used to edit a specified Legal Person
    internal init(legalPerson : Binding<LegalPerson>) {
        edit = true
        self.legalPerson = legalPerson
        _legalPersonType = State(initialValue: Converter.legalPersonType(for: legalPerson.wrappedValue))
        _name = State(initialValue: legalPerson.wrappedValue.name)
        _notes = State(initialValue: legalPerson.wrappedValue.notes)
        _phone = State(initialValue: legalPerson.wrappedValue.phone)
        if legalPerson.wrappedValue is Union {
            let lp : Union = legalPerson.wrappedValue as! Union
            _homepage = State(initialValue: lp.homepage?.absoluteString ?? "")
        }
    }

    var body: some View {
        GeometryReader { metrics in
            VStack {
                List {
                    Section {
                        TextField("Name", text: $name)
                            .textContentType(.name)
                            .onSubmit {
                                checkBtn()
                            }
                        TextField("Notes", text: $notes, axis: .vertical)
                            .lineLimit(5)
                            .textContentType(.familyName)
                    } header: {
                        Text("General")
                    } footer: {
                        Text("\(labelText) the general Value every Legal Person has")
                    }
                    .keyboardType(.alphabet)
                    Section {
                        Picker("Type", selection: $legalPersonType) {
                            ForEach(LegalPerson.LegalPersonType.allCases) {
                                type in
                                Text(type.rawValue.capitalized)
                            }.onSubmit {
                                checkBtn()
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
                    btnActive ? addLegalPerson() : nil
                } label: {
                    Spacer()
                    Label("Save", systemImage: "square.and.arrow.down")
                        .frame(width: metrics.size.width / 1.2,
                               height: metrics.size.height / 15)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                    Spacer()
                }
            }
        }
        .textFieldStyle(.plain)
        .pickerStyle(.automatic)
        .navigationTitle("\(edit ? "Edit" : "Create") Legal Person")
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
                    Text("\(labelText) the specific Information about this Legal Person")
                }
            default:
                EmptyView()
        }
    }

    /// Represents the Text for a label depending on
    /// whether this Screen is in edit mode or not.
    private var labelText : String {
        get {
            return edit ? "Edit" : "Enter"
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
        if edit {
            LegalPersonList.instance.replace(
                toReplace: legalPerson!.wrappedValue,
                replace: person
            )
            legalPerson!.wrappedValue = person
        } else {
            LegalPersonList.instance.add(item: person)
        }
        SecureStorage.storeLegalPersons()
        dismiss()
    }

    /// Checks if the Button should be active
    /// To enable the Button, all required Values
    /// must be entered
    private func checkBtn() -> Void {
        btnActive = !name.isEmpty && legalPersonType != .none
    }
}

struct CreateLegalPerson_Previews: PreviewProvider {
    static var previews: some View {
        CreateLegalPerson(type: .person)
    }
}
