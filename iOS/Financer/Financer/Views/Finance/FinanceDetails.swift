//
//  FinanceDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 22.12.22.
//

import SwiftUI

/// The View to show details about a Finance
internal struct FinanceDetails: View {
    
    /// The View Context communicating with the Core
    /// Data Manager of this App.
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The Action to dismiss  this View programmatically
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    /// The FInance Wrapper being injected into the Environment
    @EnvironmentObject private var financeWrapper : FinanceWrapper
    
    /// The User Wrapper in this App to interact with the User
    @EnvironmentObject private var userWrapper : UserWrapper
    
    /// Whether the Details of a Person are shown or not
    @State private var personDetailsPresented : Bool = false
    
    /// Whether the Error when saving is presented or not.
    @State private var errSavingPresented : Bool = false
    
    /// Whether to delete this Finance after closing this Screen or not
    @Binding internal var deleteFinanceFromDetails : Bool
    
    var body: some View {
        NavigationStack {
            List {
                generalValuesSection()
                optionalValuesSection()
                relationValuesSection()
            }
            .navigationTitle("\(financeWrapper.finance!.typeAsString()) Details")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        EditFinance()
                            .environmentObject(financeWrapper)
                            .environmentObject(userWrapper)
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        deleteFinanceFromDetails.toggle()
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .renderingMode(.original)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    
    /// This renders, builds and returns the Section
    /// for the General Values
    @ViewBuilder
    private func generalValuesSection() -> some View {
        Section {
            HStack {
                Text("Amount")
                Spacer()
                Text(financeWrapper.finance!.fullAmount)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("On")
                Spacer()
                Text(financeWrapper.finance!.date!, style: .date)
                    .foregroundColor(.gray)
            }
            if !financeWrapper.finance!.isPeriodical {
                HStack {
                    Text("At")
                    Spacer()
                    Text(financeWrapper.finance!.date!, style: .time)
                        .foregroundColor(.gray)
                }
            }
        } header: {
            Text("General Values")
        } footer: {
            Text("These are the general Values for this \(financeWrapper.finance!.typeAsString())")
        }
    }
    
    
    /// This renders, builds and returns the Section
    /// for the optional Values
    @ViewBuilder
    private func optionalValuesSection() -> some View {
        Section {
            if financeWrapper.finance!.isPeriodical {
                ListTile(name: "Period Duration", data: "\(financeWrapper.finance!.periodDuration) days")
            }
            Text(notes)
                .lineLimit(5...10)
                .foregroundColor(.gray)
        } header: {
            Text("Optional Data")
        } footer: {
            Text("These Data are optional and you may have not added them.")
        }
    }
    
    
    /// This renders, builds and returns the Section
    /// for the finances Relations
    @ViewBuilder
    private func relationValuesSection() -> some View {
        Section {
            ListTile(
                name: financeWrapper.finance!.directionAsString,
                data: financeWrapper.finance!.legalPerson!.name!,
                onTap: {
                    personDetailsPresented.toggle()
                },
                textContentType: .name
            )
            .swipeActions {
                //                DeleteButton(action: )
            }
            .sheet(isPresented: $personDetailsPresented) {
                LegalPersonDetails()
            }
            if financeWrapper.finance!.isPeriodical {
                ForEach((financeWrapper.finance!.periodicallyConnectedFinances!.allObjects as! [Finance])) {
                    finance in
                    ListTile(
                        name: finance.typeAsString(),
                        data: String(Double(truncating: finance.amount!)),
                        onTap: {
                            financeWrapper.finance = finance
                        }
                    )
                }
            }
        } header: {
            Text("Relations")
        } footer: {
            Text("Represents all relations this Finance has.")
        }
    }
    
    /// The Notes shown in this View.
    /// If the Notes to this Finance are empty,
    /// this returns an information String
    /// stating exactly that.
    private var notes : String {
        if financeWrapper.finance!.notes!.isEmpty {
            return "No Notes"
        } else {
            return financeWrapper.finance!.notes!
        }
    }
}

internal struct FinanceDetails_Previews: PreviewProvider {
    /// The State Object to use in this Preview
    @StateObject private static var fW : FinanceWrapper = FinanceWrapper(finance: Finance.anonymous)
    
    /// The State Object to use in this Preview
    @StateObject private static var uW : UserWrapper = UserWrapper(user: User.anonymous)
    
    /// The State Boolean to delete a Finance from details used in this Preview
    @State private static var deleteFinanceFromDetails : Bool = false
    
    static var previews: some View {
        FinanceDetails(deleteFinanceFromDetails: $deleteFinanceFromDetails)
            .environmentObject(fW)
            .environmentObject(uW)
    }
}
