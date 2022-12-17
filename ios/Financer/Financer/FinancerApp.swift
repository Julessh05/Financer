//
//  FinancerApp.swift
//  Financer
//
//  Created by Julian Schumacher on 17.12.22.
//

import SwiftUI

@main
struct FinancerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
