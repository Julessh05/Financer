    //
    //  FinanceDetails.swift
    //  Financer
    //
    //  Created by Julian Schumacher on 22.12.22.
    //

import SwiftUI

/// The View to show details about a Finance
internal struct FinanceDetails: View {

    /// The Finance to show the details for.
    let finance : Finance
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    
                } footer: {
                    
                }
            }
            .navigationTitle("Finance Details")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                
            }
        }
    }
}

struct FinanceDetails_Previews: PreviewProvider {
    /// The Finance used for this preview.
    static var finance : Finance = Finance.anonymous
    
    static var previews: some View {
        FinanceDetails(finance: finance)
    }
}
