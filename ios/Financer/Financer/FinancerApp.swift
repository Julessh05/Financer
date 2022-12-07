//
//  FinancerApp.swift
//  Financer
//
//  Created by Julian Schumacher on 29.10.22.
//

import SwiftUI

@main
struct FinancerApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
                .onAppear(perform: {
                    Storage.loadAllData()
                    User.currentUser = User()
                })
        }
    }
}
