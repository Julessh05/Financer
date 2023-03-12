//
//  FinancerApp.swift
//  Financer
//
//  Created by Julian Schumacher on 29.10.22.
//

import SwiftUI

@main
internal struct FinancerApp: App {
    
    /// The Persistence Controller used in this App.
    ///
    /// The Context of this Controller is injeected into the
    /// environment via the .environment modifier which is available on
    /// the view struct.
    private let persistenceController : PersistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeInit()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .windowStyle(.hiddenTitleBar)
        // Settings Struct from here: https://developer.apple.com/documentation/swiftui/settings
        Settings {
            SettingsView()
        }
    }
}
