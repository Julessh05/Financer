//
//  FinancerApp.swift
//  Financer
//
//  Created by Julian Schumacher on 21.12.22.
//

import SwiftUI

@main
struct FinancerApp: App {
    /// The Persistence Controller used in this App.
    ///
    /// The Context of this Controller is injeected into the
    /// environment via the .environment modifier which is available on
    /// the view struct.
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
