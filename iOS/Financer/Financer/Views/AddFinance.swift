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
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Amount", text: $amount)
                } header: {
                    Text("General Information")
                } footer: {
                    Text("It's required to enter these Information")
                }
            }
            .navigationTitle("Add Finance")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
