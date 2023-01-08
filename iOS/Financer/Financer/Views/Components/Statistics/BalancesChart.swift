//
//  BalancesChart.swift
//  Financer
//
//  Created by Julian Schumacher on 07.01.23.
//

import Charts
import SwiftUI

/// A View representing a Chart
/// of the specified balances
internal struct BalancesChart: View {
    
    /// The Balances to display in this Chart
    internal let balances : [(date : Date, amount : Double)]
    
    var body: some View {
        Chart(balances, id: \.date) {
            balance in
            LineMark(
                x: .value(
                    "Date",
                    balance.date
                ),
                y: .value(
                    "Balance",
                    balance.amount
                )
            )
        }
    }
}

internal struct BalancesChart_Previews: PreviewProvider {
    static var previews: some View {
        BalancesChart(balances: [])
    }
}
