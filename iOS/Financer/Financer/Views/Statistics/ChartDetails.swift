//
//  ChartDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 04.01.23.
//

import Charts
import SwiftUI

/// The View to display a collection of different charts
/// representing different Data
internal struct ChartDetails: View {
    
    /// The Balances on the different Dates
    /// in form of an Array containing an anonymous Object
    /// with date and amount
    /// This should contain all balances of the App
    internal let balances : [(date : Date, amount : Double)]
    
    var body: some View {
        NavigationStack {
            BalancesChart(balances: balances)
                .navigationTitle("Charts")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

internal struct ChartDetails_Previews: PreviewProvider {
    static var previews: some View {
        ChartDetails(balances: [])
    }
}
