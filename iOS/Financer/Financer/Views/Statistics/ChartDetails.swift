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
    
    /// The Balances Map on the different Dates
    internal let balances : [(date : Date, amount : Double)]
    
    var body: some View {
        NavigationStack {
            Chart {
                
            }
            Chart {
                
            }
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
