//
//  Home.swift
//  Financer
//
//  Created by Julian Schumacher on 12.03.23.
//

import SwiftUI

/// The Real Home View, which
/// represents the initial and main View of this App
internal struct Home: View {
    
    // Preview Code Start
    // (Comment to build)
    //
    // This Code is used in development because it works with the preview.
    // Solution from: https://developer.apple.com/forums/thread/654126
    
    /// The Finances fetched from
    /// the Core Database
    @FetchRequest(fetchRequest: financeFetchRequest)
    private var finances : FetchedResults<Finance>
    
    /// This is the fetch Request to fetch all the Finances
    /// from the Core Data Persistence Storage
    static private var financeFetchRequest : NSFetchRequest<Finance> {
        let request = Finance.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(
                keyPath: \Finance.date,
                ascending: false
            )
        ]
        return request
    }
    // Preview Code End
    
    
    // Production Code Start
    // (Uncomment to build)
    //
    // This Code is used in production, because this Code
    // is generated by Apple and it is shorter.
    // This just doesn't work with the Preview
    
    /// The Finances fetched form the
    /// Code Database.
    //    @FetchRequest(
    //        sortDescriptors: [
    //            SortDescriptor(\Finance.date, order: .reverse)
    //        ]
    //    ) private var finances : FetchedResults<Finance>
    // Production Code End
    
    var body: some View {
        List {
            ForEach(finances) {
                finance in
                HStack {
                    Text(String(finance.fullAmount))
                    Text(finance.legalPerson!.name!)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
