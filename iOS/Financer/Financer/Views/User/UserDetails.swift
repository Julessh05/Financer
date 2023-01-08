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
    
    /// Whether the Edit user View is Presented or not
    @State private var editPresented : Bool = false
    
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
                Section {
                    ListTile(name: "First Name", data: user.firstname!)
                    ListTile(name: "Last Name", data: user.lastname!)
                    dateOfBirthSection()
                } header: {
                    Text("General")
                } footer: {
                    Text("General Information about the User")
                }
                Section {
                    ListTile(name: "Current Balance", data: String(user.balance))
                } header: {
                    Text("App Related")
                } footer: {
                    Text("App Relation Information about the User")
                }
            }
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        editPresented.toggle()
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .sheet(isPresented: $editPresented) {
                        EditUser()
                            .environmentObject(userWrapper)
                    }
                }
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
    
    @ViewBuilder
    private func dateOfBirthSection() -> some View {
        if userWrapper.user!.dateOfBirth != nil {
            HStack {
                Text("Date of Birth")
                Spacer()
                Text(userWrapper.user!.dateOfBirth!, style: .date)
                    .foregroundColor(.gray)
            }
        } else {
            EmptyView()
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
