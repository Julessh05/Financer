//
//  AddFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 15.11.22.
//

import SwiftUI

/// The View to add a new Finance
/// to this App
internal struct AddFinance: View {
    var body: some View {
        VStack {
            Menu("Type") {
                
            }
        }
        .navigationTitle("Add Finance")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

internal struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
