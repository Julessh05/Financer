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
    
    /// The FInance Wrapper being injected into the Environment
    @EnvironmentObject private var financeWrapper : FinanceWrapper
    
    /// Whether the Details of a Person are shown or not
    @State private var personDetailsPresented : Bool = false
    
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
                    } label: {
                        Image(systemName: "pencil")
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
                Text(String(format: "%.2f$", financeWrapper.finance!.amount))
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
            .sheet(isPresented: $personDetailsPresented) {
                LegalPersonDetails()
            }
            if financeWrapper.finance!.isPeriodical {
                ForEach((financeWrapper.finance!.periodicallyConnectedFinances!.allObjects as! [Finance])) {
                    finance in
                    ListTile(
                        name: finance.typeAsString(),
                        data: String(finance.amount),
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
    
    static var previews: some View {
        FinanceDetails()
            .environmentObject(fW)
    }
}
