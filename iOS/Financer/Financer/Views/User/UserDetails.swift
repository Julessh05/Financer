//
//  UserDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 07.01.23.
//

import SwiftUI

/// The View that displays all the Detals about a User
internal struct UserDetails: View {
    
    /// The Context to interact with Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The User Wrapper Object used in this App,
    /// containing the User beeing represented
    @EnvironmentObject private var userWrapper : UserWrapper
    
    /// Whether the log In View is presented or not.
    @State private var logInPresented : Bool = false
    
    var body: some View {
        VStack {
            userDetails()
        }
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.automatic)
    }
    
    /// Renders, build and returns the
    /// Body of the User Details View
    @ViewBuilder
    private func userDetails() -> some View {
        if userWrapper.user != nil {
            let user : User = userWrapper.user!
            List {
                DefaultListTile(name: "First Name", data: user.firstname!)
                DefaultListTile(name: "Last Name", data: user.lastname!)
                DefaultListTile(name: "Current Balance", data: String(user.balance))
            }
        } else {
            VStack {
                Button("Sign in") {
                    logInPresented.toggle()
                }
                .sheet(isPresented: $logInPresented) {
                    LogInUser()
                        .environmentObject(userWrapper)
                }
            }
        }
    }
}

internal struct UserDetails_Previews: PreviewProvider {
    
    /// The User Wrapper beeing used in this Preview
    @StateObject private static var userWrapperPreview : UserWrapper = UserWrapper(user: User.anonymous)
    
    static var previews: some View {
        UserDetails()
            .environmentObject(userWrapperPreview)
    }
}
