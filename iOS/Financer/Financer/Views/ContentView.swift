//
//  ContentView.swift
//  Financer
//
//  Created by Julian Schumacher on 21.12.22.
//

import SwiftUI
import CoreData

/// The first View shown to the User when opening
/// the App.
internal struct ContentView: View {
    /// The ViewContext 
    @Environment(\.managedObjectContext) private var viewContext

    /// The Finances fetched from
    /// the Core Database
    @FetchRequest(fetchRequest: financeFetchRequest)
    private var finances : FetchedResults<Finance>
    
    /// This is the fetch Request to fetch all the Finances
    /// from the Core Data Persistence Storage
    static private var financeFetchRequest : NSFetchRequest<Finance> {
        let request = Finance.fetchRequest()
        request.sortDescriptors = []
        return request
    }

    var body: some View {
        NavigationStack {
            List(finances) {
                finance in
                NavigationLink(
                    destination: { FinanceDetails() },
                    label: { label(finance) })
            }
            .navigationTitle("Welcome")
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {

            }
        }
    }

    /// Builds and returns the Label
    /// of a specific Finance List Object
    @ViewBuilder
    private func label(_ finance : Finance) -> some View {
        Label(
            stringBuilder(finance: finance),
            systemImage: finance is Income ? "arrow.up" : "arrow.down"
        )
        .symbolRenderingMode(.multicolor)
    }

    /// Returns the String used in the label of the specified Finance
    private func stringBuilder(finance : Finance) -> String {
        var direction : String = ""
        if finance is Income {
            direction = "from"
        } else {
            direction = "to"
        }
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return "\(finance.amount) \(direction) \(finance.legalPerson?.name ?? "Unknown") on \(dateFormatter.string(from: finance.date!))"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
