//
//  AddLegalPerson.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//

import SwiftUI

/// View to Create or edit a Legal Person.
internal struct AddLegalPerson: View {
    
    /// The Action to dismiss this View used, because this is presented in a
    /// sheet or popover
    @Environment(\.dismiss) private var dismiss : DismissAction
    
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
    
    /// Whether ther Error when saving is displayed or not.
    @State private var errSavingPresented : Bool = false
    
    /// Whether this View is in edit mode or not.
    private let edit : Bool
    
    /// The nomal initializer to
    /// open the add legal Person
    /// View
    internal init() {
        edit = false
    }
    
    /// The initializer to pass a legal Person to
    /// open the edit Mode and edit this legal Person.
    internal init(legalPerson : Binding<LegalPerson>) {
        edit = true
        name = legalPerson.wrappedValue.name!
        notes = legalPerson.wrappedValue.notes ?? ""
        phone = legalPerson.wrappedValue.phone ?? ""
        if legalPerson.wrappedValue is Union {
            let person = legalPerson.wrappedValue as! Union
            homepage = person.url?.absoluteString ?? ""
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
                            .onSubmit { checkBtn() }
                        Picker("Type", selection: $legalPersonType) {
                            ForEach(LegalPerson.LegalPersonType.allCases) {
                                person in
                                Text(person.rawValue.capitalized)
                            }
                        }
                        .onSubmit { checkBtn() }
                        // TODO: decide on Style
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
                Button(action: addLegalPerson) {
                    Label(
                        "Save",
                        systemImage: "square.and.arrow.down"
                    )
                    .frame(
                        width: metrics.size.width / 1.2,
                        height: metrics.size.height / 15
                    )
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                }
                .alert(
                    "Missing Data",
                    isPresented: $errMissingArgumentsPresented
                ) {
                } message: {
                    Text("Please enter all required Data before you continue")
                }
                .alert(
                    "Error",
                    isPresented: $errSavingPresented
                ) {
                    
                } message: {
                    Text(
                        "Error saving Data.\nPlease try again\n\nIf this Error occurs again, please contact the support."
                    )
                }
            }
            .navigationTitle("\(edit ? "Edit" : "Add" ) Legal Person")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear { checkBtn() }
            .textFieldStyle(.plain)
            .formStyle(.grouped)
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        addLegalPerson()
                        dismiss()
                    }
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
    
    /// If all Data are entered this creates and adds the Legal
    /// Person to the Core Data.
    /// If not all Data are entered, this shows an Error Message
    private func addLegalPerson() -> Void {
        if btnActive {
            var legalPerson : LegalPerson
            switch legalPersonType {
                case .organization:
                    legalPerson = Organization(context: viewContext)
                    break
                case .company:
                    legalPerson = Company(context: viewContext)
                    break
                case .person:
                    legalPerson = Person(context: viewContext)
                    break
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
            do {
                try viewContext.save()
            } catch _ {
                errSavingPresented.toggle()
            }
        } else {
            errMissingArgumentsPresented.toggle()
        }
    }
}

internal struct AddLegalPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddLegalPerson()
    }
}
