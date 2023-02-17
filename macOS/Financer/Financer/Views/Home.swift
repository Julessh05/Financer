//
//  ContentView.swift
//  Financer
//
//  Created by Julian Schumacher as ContentView.swift on 29.10.22.
//
//  Renamed by Julian Schumacher to Home.swift on 08.01.23
//

import SwiftUI

/// The Home View of this App, that is shown
/// when opening the App.
internal struct Home: View {
    
    /// The Finances fetched form the
    /// Code Database.
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\Finance.date, order: .reverse)
        ]
    ) private var finances : FetchedResults<Finance>
    
    var body: some View {
        NavigationSplitView {
            List {
                HStack {
                    Image(systemName: "house")
                        .renderingMode(.original)
                    Text("Home")
                }
                ForEach(finances) {
                    finance in
                    financesLabel(finance)
                }
                
            }
        } detail: {
            
        }
    }
    
    /// Builds, renders and returns the Label
    /// for each Finance in the Navigation Bar
    @ViewBuilder
    private func financesLabel(_ finance : Finance) -> some View {
        HStack {
            Image(systemName: finance is Income ? "plus" : "minus")
                .renderingMode(.original)
            Text(String(finance.amount))
        }
    }
}

internal struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
