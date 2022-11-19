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

    /// The Type of this Finance
    @State private var financeType : Finance.FinanceType = .income

    /// The Amount of this Finance
    @State private var amount : String = ""

    /// The Type of legal Person this
    /// Finance is connected to
    @State private var legalPerson : LegalPerson.LegalPersonType = .none

    var body: some View {
        Form {
            Section {
                Picker("Type", selection: $financeType) {
                    ForEach(Finance.FinanceType.allCases) {
                        c in
                        Text(c.rawValue.capitalized)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
            } header: {
                Text("Type")
            } footer: {
                Text("The Amount of Money transfered with this Finance")
            }
            Section {
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
