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
    @Environment(\.managedObjectContext) private var viewContext

    /// The Finances fetched from
    /// the Core Database
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.date, order: .reverse),
            SortDescriptor(\.amount, order: .reverse)
        ],
        animation: .default
    )
    private var finances : FetchedResults<Finance>

    var body: some View {
        NavigationStack {
            List(finances) {
                finance in
                NavigationLink(destination: { FinanceDetails() }, label: { label(finance) })
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
        let direction : String
        if finance is Income {
            direction = "from"
        } else {
            direction = "to"
        }
        return "\(finance.amount) \(direction) \(finance.legalPerson!.name) on \(finance.date?.description)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
