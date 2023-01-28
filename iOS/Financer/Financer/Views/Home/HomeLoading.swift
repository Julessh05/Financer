//
//  HomeInit.swift
//  Financer
//
//  Created by Julian Schumacher as HomeInit.swift on 28.01.23.
//
//  Renamed by Julian Schumacher to HomeLoading.swift on 28.01.23.
//

import SwiftUI

/// This View is just a Wrapper around the actual Home View to
/// initialize stuff and prepare the App for the
/// Home View
internal struct HomeInit: View {
    
    /// The Context to interact with Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The User Wrapper for the User of this App
    @EnvironmentObject private var userWrapper : UserWrapper
    
    /// The Users in this App
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\User.firstname)
        ]
    ) private var users : FetchedResults<User>
    
    /// Whether this View is in Loading Mode or not
    @State private var isLoading : Bool = true
    
    var body: some View {
        homeBuilder()
    }
    
    /// Builds, renders and returns the Body of this
    /// View, depending on the Loading Mode
    @ViewBuilder
    private func homeBuilder() -> some View {
        if !isLoading {
            Home()
                .environmentObject(userWrapper)
        } else {
            ProgressView()
                .onAppear {
                    initUser()
                }
        }
    }
    
    /// initializes the anonym User of this App
    /// This is called only once in the Initializer of this View.
    /// If the User is already set, it will not be set again
    private func initUser() -> Void {
        guard userWrapper.user == nil else {
            isLoading = false
            return
        }
        if !users.isEmpty {
            userWrapper.user = users.first!
        } else {
            let anonymUser : User = User(context: viewContext)
            anonymUser.firstname = "Julian"
            anonymUser.lastname = "Schumacher"
            let calendar : Calendar = Calendar.current
            var dateComponents : DateComponents = DateComponents()
            dateComponents.year = 2005
            dateComponents.month = 2
            dateComponents.day = 22
            anonymUser.dateOfBirth = calendar.date(from: dateComponents)!
            anonymUser.gender = User.Gender.male.rawValue
            anonymUser.userCreated = false
            userWrapper.user = anonymUser
        }
        isLoading = false
    }
}

/// The Preview for the Home Init View
internal struct HomeInit_Previews: PreviewProvider {
    
    /// The User Wrapper Environment Object
    /// used in this Environment
    @StateObject private static var userWrapperPreview : UserWrapper = UserWrapper(user: User.anonymous)
    
    static var previews: some View {
        HomeInit()
            .environmentObject(userWrapperPreview)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
