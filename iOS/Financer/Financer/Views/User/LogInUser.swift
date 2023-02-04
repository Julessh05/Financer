//
//  LogInUser.swift
//  Financer
//
//  Created by Julian Schumacher on 07.01.23.
//

import SwiftUI

/// This View provides the Opportunity for the
/// User to log in
internal struct LogInUser: View {
    
    /// The context that manages the Core Data in this App
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The User Wrapper containing the current User
    @EnvironmentObject private var userWrapper : UserWrapper
    
    /// Whether ther Error when saving is displayed or not.
    @State private var errSavingPresented : Bool = false
    
    var body: some View {
        NavigationStack {
            UserEditor(action: addUser)
                .navigationTitle("Log In")
                .alert(
                    "Error",
                    isPresented: $errSavingPresented
                ) {
                    
                } message: {
                    Text(
                        "Error saving Data.\nPlease try again\n\nIf this Error occurs again, please contact the support."
                    )
                }
        }
    }
    
    /// The Function called to add  a User
    private func addUser(user : User) -> Void {
        do {
            try userWrapper.logIn(newUser: user)
        } catch _ {
            errSavingPresented.toggle()
        }
    }
}

internal struct LogInUser_Previews: PreviewProvider {
    static var previews: some View {
        LogInUser()
    }
}
