//
//  FinanceDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 17.02.23.
//

import SwiftUI

/// The View showing details for the passed finance
internal struct FinanceDetails: View {
    
    /// The Finance to generate this View for.
    internal let finance : Finance
    
    var body: some View {
        List {
            Section {
                
            } header: {
                Text("General")
            } footer: {
                Text("These are the general and required Data, so all Finances have them.")
            }
            Section {
                
            } header: {
                Text("Optional")
            } footer: {
                Text("These are optional Data, so you may have not entered them")
            }
        }
    }
}

internal struct FinanceDetails_Previews: PreviewProvider {
    static var previews: some View {
        FinanceDetails(finance: Finance.anonymous)
    }
}
