//
//  AddFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 22.02.23.
//

import SwiftUI

/// This is the View to add a new Finance.
internal struct AddFinance: View {
    
    /// The Amount entered in the corresponding Textfield
    @State private var amount : String = ""
    
    var body: some View {
        VStack {
            TextField("amount", text: $amount)
                .textFieldStyle(.squareBorder)
        }
    }
}

internal struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
