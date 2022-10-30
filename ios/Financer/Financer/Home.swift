//
//  Home.swift
//  Financer
//
//  Created by Julian Schumacher on 29.10.22.
//

import SwiftUI

/// Home View
internal struct Home: View {

    /// Initializer without User.
    /// Used if the App User has not
    /// creeated a User Account to that point.
    internal init() {
        user = nil
    }

    /// Initializer with User.
    /// Mostly used.
    internal init(user : User) {
        self.user = user
    }

    /// The User logged in.
    private let user : User?

    var body: some View {
        NavigationView {
            List {

            }.navigationTitle("Welcome \(user?.name ?? "")")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
