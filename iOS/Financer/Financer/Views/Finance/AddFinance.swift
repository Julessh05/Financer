//
//  AddFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 23.12.22.
//

import SwiftUI

/// The View to add a new Finance
internal struct AddFinance: View {
    
    /// The dismiss Action to dismiss this View.
    ///
    /// This is used, because this view is presented as a sheet or popover.
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    /// The Text of the "Amount" Textfield
    @State private var amount : String = ""
    
    /// The Legal Person connected to this Finance
    @State private var legalPerson : LegalPerson?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Amount", text: $amount)
                    NavigationLink {
                        LegalPersonPicker(
                            legalPerson: $legalPerson
                        )
                    } label: {
                        legalPersonNavigationLabel()
                    }
                } header: {
                    Text("General Information")
                } footer: {
                    Text("It's required to enter these Information")
                }
                Section {
                    
                } header: {
                    
                } footer: {
                    
                }
            }
            .navigationTitle("Add Finance")
            .navigationBarTitleDisplayMode(.automatic)
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
                        dismiss()
                    }
                }
            }
        }
    }
    
    /// Builds and returns the label
    /// connected to the navigation Link which
    /// points to the Legal Person Picker
    @ViewBuilder
    private func legalPersonNavigationLabel() -> HStack<TupleView<(Text, Spacer, Text)>> {
        HStack {
            Text("Legal Person")
            Spacer()
            Text(legalPerson?.name ?? "None")
                .foregroundColor(.gray)
        }
    }
}

struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
