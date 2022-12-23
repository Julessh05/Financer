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
        request.sortDescriptors = [
            NSSortDescriptor(
                keyPath: \Finance.date,
                ascending: true
            )
        ]
        return request
    }
    
    @State private var addPresented : Bool = false

    var body: some View {
        NavigationStack {
            List(finances) {
                finance in
                NavigationLink(
                    destination: { FinanceDetails() },
                    label: { label(finance) })
            }
            Button {
                addPresented.toggle()
            } label: {
                Label("Add Finance", systemImage: "plus")
            }.sheet(
                isPresented: $addPresented,
                content: { AddFinance() }
            )
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {}
        }
    }

    /// Builds and returns the Label
    /// of a specific Finance List Object
    @ViewBuilder
    private func label(_ finance : Finance) -> some View {
        HStack {
            Image(systemName: finance is Income ? "plus" : "minus")
                .renderingMode(.original)
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text("\(finance.amount)€")
                    .font(.headline)
                    .foregroundColor(finance is Income ? .green : .red)
                Text(finance.legalPerson?.name ?? "Unknown")
                Text(finance.date!, format: .dateTime.day().month().year())
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
