//
//  Home.swift
//  Financer
//
//  Created by Julian Schumacher on 29.10.22.
//

import SwiftUI

/// Home View
internal struct Home: View {

    @Environment(\.currentUser) var user

    internal var body: some View {
        NavigationView {
            ScrollView {

            }
            .navigationTitle("Welcome \(user.name)")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    user.picture != nil ? Image(uiImage: user.picture!) : Image(systemName: "person.circle.fill")
                }
            }
        }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
