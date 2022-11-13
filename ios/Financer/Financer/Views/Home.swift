//
//  Home.swift
//  Financer
//
//  Created by Julian Schumacher on 29.10.22.
//

import SwiftUI

/// Home View
/// This is the View shown when the User opens
/// the App.
internal struct Home: View {
    /// The current User used in this App
    @State private var user : User = User()

    internal var body: some View {
        NavigationView {
            ScrollView {
            }
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: UserDetails(user: $user), label: profileIcon
                    )

                }
            }

        }

    }

    /// Returns the Icon for the profile iin this
    @ViewBuilder
    private func profileIcon() -> some View {
        if user.picture != nil {
            Image(uiImage: user.picture!)
                .backgroundStyle(.clear)
        } else {
            Image(systemName: "person.circle.fill")
                .background(.clear)
                .foregroundColor(.primary)
                .buttonStyle(.plain)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
