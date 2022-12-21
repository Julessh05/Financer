//
//  ContentView.swift
//  Financer
//
//  Created by Julian Schumacher on 21.12.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Finance.amount, ascending: true)],
        animation: .default)
    private var finances: FetchedResults<Finance>

    var body: some View {
        NavigationView {
            Text("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
