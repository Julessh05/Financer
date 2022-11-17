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

    var body: some View {
        VStack {
            Picker("Type", selection: $financeType) {
                ForEach(FinanceType.allCases) {
                    c in
                    Text(c.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            buildBody()
        }
        .padding(.horizontal, 15)
        .navigationTitle("Add Finance")
        .navigationBarTitleDisplayMode(.automatic)
    }

    @ViewBuilder
    private func buildBody() -> some View {
        Spacer()
    }
}

internal struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
