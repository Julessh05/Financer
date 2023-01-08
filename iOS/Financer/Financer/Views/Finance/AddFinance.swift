//
//  AddFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 23.12.22.
//

import SwiftUI

/// The View to add a new Finance
internal struct AddFinance: View {
    
    /// The Context used to interact with the Core Data
    /// Manager
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The User Wrapper being used to upate the User Balance
    @EnvironmentObject private var userWrapper : UserWrapper
    
    /// Whether ther Error when saving is displayed or not.
    @State private var errSavingPresented : Bool = false
    
    var body: some View {
        NavigationStack {
            FinanceEditor(action: addFinance)
                .navigationTitle("Add Finance")
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
    
    /// Creates and adds the Finance to the Core Data.
    private func addFinance(finance : Finance) -> Void {
        userWrapper.addFinance(finance)
        do {
            try viewContext.save()
        } catch _ {
            errSavingPresented.toggle()
        }
    }
}

internal struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
