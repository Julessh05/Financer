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
    
    /// The Name of this Legal Person
    @State private var name : String = ""
    
    /// Whether the Button is active (all Data are entered) or not.
    @State private var btnActive : Bool = false
    
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
    // TODO: remove s
    internal init(s : String) {
        edit = true
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .keyboardType(.asciiCapable)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .lineLimit(1)
                } header: {
                    Text("Required Information")
                } footer: {
                    Text("It's required to enter these Information")
                }            }
            .navigationTitle("\(edit ? "Edit" : "Add" ) Legal Person")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear(perform: { checkBtn() })
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
    
    /// Checks if all required Data are entered, and if so
    /// activates the Button.
    private func checkBtn() -> Void {
        btnActive = !name.isEmpty
    }
    
    /// If all Data are entered this creates and adds the Legal
    /// Person to the Core Data.
    /// If not all Data are entered, this shows an Error Message
    private func addLegalPerson() -> Void {
        if btnActive {
            
        } else {
            
        }
    }
}

internal struct AddLegalPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddLegalPerson()
    }
}
