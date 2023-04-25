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
    
    /// Whether the Error Alert Dialog when saving data is presented or not.
    @State private var errSavingPresented : Bool = false
    
    /// Whether the information sheet is presented or not
    @State private var informationPresented : Bool = false
    
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
        if let user = userWrapper.user, user.userCreated {
            GeometryReader {
                metrics in
                VStack {
                    List {
                        imageSection()
                        Section {
                            ListTile(name: "First Name", data: user.firstname!, textContentType: .givenName)
                            ListTile(name: "Last Name", data: user.lastname!, textContentType: .familyName)
                            dateOfBirthSection()
                            genderSection()
                        } header: {
                            Text("General")
                        } footer: {
                            Text("General Information about the User")
                        }
                        Section {
                            ListTile(name: "Current Balance", data: "\(user.balance!.stringValue)\(Locale.current.currencySymbol!)")
                        } header: {
                            Text("App Related")
                        } footer: {
                            Text("App Relation Information about the User")
                        }
                    }
                    Button(action: logOut) {
                        Label(
                            "Delete Account",
                            systemImage: "trash"
                        )
                        .frame(
                            width: metrics.size.width / 1.2,
                            height: metrics.size.height / 15
                        )
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
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
            GeometryReader {
                metrics in
                VStack {
                    List {
                        ListTile(name: "Current Balance",
                                 // TODO: add currency
                                 data: "\(userWrapper.balance.stringValue)\(Locale.current.currencySymbol!)")
                    }
                    Button {
                        logInPresented.toggle()
                    } label: {
                        Label(
                            "Create Account",
                            systemImage: "plus"
                        )
                        .frame(
                            width: metrics.size.width / 1.2,
                            height: metrics.size.height / 15
                        )
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                }
                .sheet(isPresented: $logInPresented) {
                    LogInUser()
                        .environmentObject(userWrapper)
                }
            }
        }
        Button("More Information") {
            informationPresented.toggle()
        }
        .sheet(isPresented: $informationPresented) {
            UserInformation()
        }
    }
    
    /// Renders, builds and returns the User Image, if so stored.
    @ViewBuilder
    private func imageSection() -> some View {
        if userWrapper.user!.image != nil {
            Image(uiImage: UIImage(data: userWrapper.user!.image!)!)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
        }
    }
    
    /// Builds, renders and returns the Section showing
    /// the Date of Birth of the User (if entered)
    @ViewBuilder
    private func dateOfBirthSection() -> some View {
        if userWrapper.user!.dateOfBirth != nil {
            HStack {
                Text("Date of Birth")
                Spacer()
                Text(userWrapper.user!.dateOfBirth!, style: .date)
                    .textContentType(.dateTime)
                    .foregroundColor(.gray)
            }
        }
    }
    
    /// Builds, renders and returns the Section displaying the
    /// Gender of the User (if entered)
    @ViewBuilder
    private func genderSection() -> some View {
        if userWrapper.user!.gender != User.Gender.none.rawValue {
            ListTile(name: "Gender", data: userWrapper.user!.gender!.capitalized)
        }
    }
    
    /// Logs the User out of the App and deletes the User
    /// from the local Storage
    private func logOut() -> Void {
        do {
            try userWrapper.logOut()
        } catch _ {
            errSavingPresented.toggle()
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
