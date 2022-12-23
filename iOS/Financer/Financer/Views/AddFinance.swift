//
//  AddFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 23.12.22.
//

import SwiftUI

internal struct AddFinance: View {
    
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    @State private var amount : String = ""
    
    var body: some View {
        NavigationStack {
            TextField("Amount", text: $amount)
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
