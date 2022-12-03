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
    @State private var user : User = User.currentUser

    @State private var list : [Finance] = FinanceList.instance.items

    internal var body: some View {
        NavigationStack {
            VStack {
                List(list) {
                    finance in
                    Text(finance.type.rawValue)
                }.onAppear(perform: { list = FinanceList.instance.items })
                NavigationLink(destination: AddFinance()) {
                    Label("Add Finance", systemImage: "plus")
                }
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
                .resizable()
                .scaledToFill()
                .backgroundStyle(.clear)
                .frame(width: 25, height: 25)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .background(.clear)
                .foregroundColor(.primary)
                .buttonStyle(.plain)
                .clipShape(Circle())
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
