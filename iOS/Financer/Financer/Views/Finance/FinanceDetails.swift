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
    
    /// The Finance to show the details for.
    @State internal var finance : Finance
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("Amount")
                        Spacer()
                        Text(String(format: "%.2f$", finance.amount))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("On")
                        Spacer()
                        Text(finance.date!, style: .date)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("At")
                        Spacer()
                        Text(finance.date!, style: .time)
                            .foregroundColor(.gray)
                    }
                } header: {
                    Text("General Values")
                } footer: {
                    Text("These are the general Values for this \(typeLabel)")
                }
                Section {
                    Text(notes)
                        .lineLimit(5...10)
                        .foregroundColor(.gray)
                } header: {
                    Text("Optional Data")
                } footer: {
                    Text("These Data are optional and you may have not added them.")
                }
                Section {
                    HStack {
                        DefaultListTile(
                            name: finance is Income ? "From" : "To",
                            data: finance.legalPerson!.name!
                        )
                    }
                } header: {
                    Text("Relations")
                } footer: {
                    Text("Represents all relations this Finance has.")
                }
            }
            .navigationTitle("\(typeLabel) Details")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        AddFinance(finance: $finance)
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
    }
    
    /// The Notes shown in this View.
    /// If the Notes to this Finance are empty,
    /// this returns an information String
    /// stating exactly that.
    private var notes : String {
        if finance.notes!.isEmpty {
            return "No Notes"
        } else {
            return finance.notes!
        }
    }
    
    /// The Label depending on the Type
    /// of Finance that was passed to this View
    private var typeLabel : String {
        return finance is Income ? "Income" : "Expense"
    }
}

internal struct FinanceDetails_Previews: PreviewProvider {
    /// The Finance used for this preview.
    static var finance : Finance = Finance.anonymous
    
    static var previews: some View {
        FinanceDetails(finance: finance)
    }
}
