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
        NavigationStack {
            StandardListTile(
                title: "Amount",
                data: String(finance.amount)
            )
            StandardListTile(
                title: "To:",
                data: finance.legalPerson.name
            )
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: AddFinance(finance: $finance)) {
                    Image(systemName: "pencil")
                }
            }
        }
        .toolbar(.visible, for: .navigationBar)
    }
}

internal struct FinanceDetails_Previews: PreviewProvider {

    @State private static var finance : Finance = Expense(
        amount: 100,
        legalPerson: LegalPerson.anonymousPerson
    )
    static var previews: some View {
        FinanceDetails(finance: $finance)
    }
}
