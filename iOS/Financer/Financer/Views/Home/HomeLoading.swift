//
//  HomeLoading.swift
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
    
    /// The initial State Object to inject into the Environment to
    /// be able to pass a finance between all Views.
    @StateObject private var financeWrapper : FinanceWrapper = FinanceWrapper()
    
    /// The Users in this App
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\User.firstname)
        ]
    ) private var users : FetchedResults<User>
    
    /// Whether this View is in Loading Mode or not
    @State private var isLoading : Bool = true
    
    /// Whether the Error Dialog when initializing is shown or not
    @State private var errPresented : Bool = false
    
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
                .environmentObject(financeWrapper)
        } else {
            // Discussion here: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
            // Answer here: https://stackoverflow.com/a/56496896/16376071
            ProgressView()
                .onAppear {
                    initUser()
                }
                .alert("Error initializing", isPresented: $errPresented) {
                    // TODO: add action
                } message: {
                    Text("There was an Error when initializing this App")
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
            userWrapper.user = users.first(
                where: { $0.userCreated }
            )
        }
        do {
            try userWrapper.initUserWrapper(
                viewContext: viewContext,
                anonymousUser: users.first(
                    where: { !$0.userCreated }
                )
            )
        } catch {
            errPresented.toggle()
            return
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
