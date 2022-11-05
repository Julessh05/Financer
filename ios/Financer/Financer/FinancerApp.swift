//
//  FinancerApp.swift
//  Financer
//
//  Created by Julian Schumacher on 29.10.22.
//

import SwiftUI

@main
struct FinancerApp: App {
    let user : User = User(name: "", lastname: "", date: Date())
    var body: some Scene {
        WindowGroup {
            Home()
        }
    }
}
