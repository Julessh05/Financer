//
//  FinancerApp.swift
//  Financer
//
//  Created by Julian Schumacher on 21.12.22.
//

import SwiftUI

/// The main Struct in this App.
/// This has the @main Annotation, indicating, that
/// this is the entrance point for this App.
@main
internal struct FinancerApp: App {
    
    /// The User Wrapper Object used in the whole App
    @StateObject private var userWrapper : UserWrapper = UserWrapper()
    
    /// The Persistence Controller used in this App.
    ///
    /// The Context of this Controller is injeected into the
    /// environment via the .environment modifier which is available on
    /// the view struct.
    private let persistenceController : PersistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(userWrapper)
                .onAppear {
                    SettingsBundleHelper.shared.setValues()
                }
        }
    }
}
