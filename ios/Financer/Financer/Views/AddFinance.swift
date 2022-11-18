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

    private enum FinanceType : String, Identifiable, CaseIterable {
        var id : Self { self }

        case income
        case expense
    }

    @State private var financeType : FinanceType = .income

    @State private var amount : String = ""

    @State private var legalPerson : LegalPerson.LegalPersonType = .none

    var body: some View {
        VStack {
            Picker("Type", selection: $financeType) {
                ForEach(FinanceType.allCases) {
                    c in
                    Text(c.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
            Spacer()
                .frame(height: 50)
            Text("Legal Person")
                .font(.title2)
            Picker("Legal Person", selection: $legalPerson) {
                ForEach(LegalPerson.LegalPersonType.allCases) { item in
                    Text(item.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            buildLegalPersonPicker()
            Spacer()
        }
        .padding(.horizontal, 15)
        .navigationTitle("Add Finance")
        .navigationBarTitleDisplayMode(.automatic)
    }

    /// Builds the Input Section
    /// depending on the legal Person Type
    @ViewBuilder
    private func buildLegalPersonPicker() -> some View {
        switch legalPerson {
            case .person, .company, .organization:
                EmptyView()
            default:
                EmptyView()
        }
    }
}

internal struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
