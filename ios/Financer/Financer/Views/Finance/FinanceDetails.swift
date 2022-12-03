//
//  FinanceDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 03.12.22.
//

import SwiftUI

/// The Details View to represent details
/// of a single Finance
internal struct FinanceDetails: View {

    @Binding internal var finance : Finance

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

internal struct FinanceDetails_Previews: PreviewProvider {

    @State private static var finance : Finance = Expense(
        amount: 100,
        legalPerson: Person(
            name: "",
            relation: .family,
            phone: "",
            notes: ""
        )
    )
    static var previews: some View {
        FinanceDetails(finance: $finance)
    }
}
