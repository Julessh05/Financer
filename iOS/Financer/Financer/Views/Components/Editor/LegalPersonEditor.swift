//
//  LegalPersonEditor.swift
//  Financer
//
//  Created by Julian Schumacher on 01.01.23.
//

import SwiftUI

/// The Editor to edit Legal Person
/// Details
internal struct LegalPersonEditor: View {
    
    /// The Action to dismiss this View used, because this is presented in a
    /// sheet or popover
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    /// The Context to interact with Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The Name of this Legal Person
    @State private var name : String = ""
    
    /// The Notes to this Legal Person
    @State private var notes : String = ""
    
    /// The phone Number of this Person
    @State private var phone : String = ""
    
    /// The Homepage of this Legal Person
    /// (only relevant if Legal Person is a Union).
    @State private var homepage : String = ""
    
    /// The Type of this Person
    @State private var legalPersonType : LegalPerson.LegalPersonType = .none
    
    /// Whether the Button is active (all Data are entered) or not.
    @State private var btnActive : Bool = false
    
    /// Whether ther Error for missing Arguments is displayed or not.
    @State private var errMissingArgumentsPresented : Bool = false
    
    /// The callback being executed when the Save or Done Button
    /// is tapped.
    private let callback : (LegalPerson) -> Void
    
    /// The Initializer to add or edit a Legal Person.
    /// If you pass a Legal Person, it will be edited, otherwise
    /// a new Person will be added.
    internal init(
        action : @escaping (LegalPerson) -> Void,
        legalPersonType : LegalPerson.LegalPersonType = .none,
        legalPerson : LegalPerson? = nil
    ) {
        callback = action
        if legalPerson != nil {
            _name = State(initialValue: legalPerson!.name!)
            _notes = State(initialValue: legalPerson!.notes!)
            _phone = State(initialValue: legalPerson!.phone!)
            _legalPersonType = State(initialValue: LegalPerson.LegalPersonType(rawValue: legalPerson!.typeAsString(capitalized: false))!)
            if legalPerson is Union {
                let p = legalPerson as! Union
                _homepage = State(initialValue: p.url?.absoluteString ?? "")
            }
        } else {
            self._legalPersonType = State(initialValue: legalPersonType)
        }
    }
    
    var body: some View {
        GeometryReader {
            metrics in
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $name)
                            .keyboardType(.asciiCapable)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)
                            .lineLimit(1)
                            .onChange(of: name) {
                                _ in
                                checkBtn()
                            }
                        Picker("Type", selection: $legalPersonType) {
                            ForEach(LegalPerson.LegalPersonType.allCases) {
                                person in
                                Text(person.rawValue.capitalized)
                            }
                        }
                        .onChange(of: legalPersonType) {
                            _ in
                            checkBtn()
                        }
                        .pickerStyle(.automatic)
                    } header: {
                        Text("Required Information")
                    } footer: {
                        Text("It's required to enter these Information.")
                    }
                    Section {
                        TextField("Notes", text: $notes, axis: .vertical)
                            .keyboardType(.asciiCapable)
                            .textInputAutocapitalization(.sentences)
                            .lineLimit(5...10)
                        TextField("Phone", text: $phone)
                            .keyboardType(.phonePad)
                            .textInputAutocapitalization(.never)
                            .textContentType(.telephoneNumber)
                        homepageField()
                    } header: {
                        Text("Optional Data")
                    } footer: {
                        Text("You don't have to enter these Information, they're just optional to provide more Information about the Person.")
                    }
                }
                Button(action: action) {
                    Label(
                        "Save",
                        systemImage: "square.and.arrow.down"
                    )
                    .frame(
                        width: metrics.size.width / 1.2,
                        height: metrics.size.height / 15
                    )
                    .foregroundColor(.white)
                    .background(btnActive ? Color.blue : Color.gray)
                    .cornerRadius(20)
                }
                .alert(
                    "Missing Data",
                    isPresented: $errMissingArgumentsPresented
                ) {
                } message: {
                    Text("Please enter all required Data before you continue")
                }
            }
        }
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden()
        .onAppear { checkBtn() }
        .textFieldStyle(.plain)
        .formStyle(.grouped)
        .toolbarRole(.navigationStack)
        .toolbar(.automatic, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    action()
                }
            }
        }
    }
    
    @ViewBuilder
    private func homepageField() -> some View {
        if legalPersonType == .company || legalPersonType == .organization {
            TextField("Homepage", text: $homepage)
                .textContentType(.URL)
                .textInputAutocapitalization(.never)
                .keyboardType(.webSearch)
        }
    }
    
    /// Checks if all required Data are entered, and if so
    /// activates the Button.
    private func checkBtn() -> Void {
        btnActive = !name.isEmpty && legalPersonType != .none
    }
    
    /// The action to create a Legal Person and pass
    /// it to the callback
    private func action() -> Void {
        if btnActive {
            let legalPerson : LegalPerson
            switch legalPersonType {
            case .organization:
                legalPerson = Organization(context: viewContext)
            case .company:
                legalPerson = Company(context: viewContext)
            case .person:
                legalPerson = Person(context: viewContext)
            default:
                errMissingArgumentsPresented.toggle()
                return
            }
            legalPerson.name = name
            legalPerson.notes = notes
            legalPerson.phone = phone
            if legalPerson is Union {
                let person = legalPerson as! Union
                person.url = URL(string: homepage)
            }
            callback(legalPerson)
            dismiss()
        } else {
            errMissingArgumentsPresented.toggle()
        }
    }
}

struct LegalPersonEditor_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonEditor(action: a)
    }
    
    /// The Function to use in this Preview
    private static func a(legalPerson : LegalPerson) -> Void {
        print("action Button pressed")
    }
}
