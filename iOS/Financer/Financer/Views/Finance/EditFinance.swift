//
//  EditFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 01.01.23.
//

import SwiftUI

/// The View to edit the in the environment specified
/// Finance.
internal struct EditFinance: View {
    
    /// The View Context used to interact with Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The Finance Wrapper in the Environment containing the
    /// Finance that should be edited.
    @EnvironmentObject private var financeWrapper : FinanceWrapper
    
    /// The User Wrapper to update the Users Balance
    @EnvironmentObject private var userWrapper : UserWrapper
    
    /// Whether ther Error when saving is displayed or not.
    @State private var errSavingPresented : Bool = false
    
    var body: some View {
        FinanceEditor(action: editFinance, finance: financeWrapper.finance!)
            .navigationBarTitle("Edit \(financeWrapper.finance!.typeAsString())")
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
    
    /// The function to edit the Finance.
    /// This is passed to the FinanceEditor
    private func editFinance(finance : Finance) -> Void {
        finance.periodicallyConnectedFinances = financeWrapper.finance!.periodicallyConnectedFinances
        userWrapper.replaceFinance(
            financeWrapper.finance!,
            with: finance
        )
        viewContext.delete(financeWrapper.finance!)
        financeWrapper.finance = finance
        do {
            try viewContext.save()
        } catch _ {
            errSavingPresented.toggle()
        }
    }
}

internal struct EditFinance_Previews: PreviewProvider {
    
    /// The Finance Wrapper used in this Preview
    @StateObject private static var financeWrapper = FinanceWrapper(finance: Finance.anonymous)
    
    static var previews: some View {
        EditFinance()
            .environmentObject(financeWrapper)
    }
}
