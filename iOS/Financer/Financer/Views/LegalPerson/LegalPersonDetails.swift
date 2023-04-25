//
//  LegalPersonDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//

import SwiftUI

/// This View represents a Legal Person and shows all
/// it's details.
internal struct LegalPersonDetails: View {
    
    /// The Managed Object Context to coordinate
    /// Core Data and all Operations
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    /// The Legal Parson beeing shown right here
    @EnvironmentObject private var legalPersonWrapper : LegalPersonWrapper
    
    /// The FinanceWrapper that is already in the Environment
    @EnvironmentObject private var financeWrapper : FinanceWrapper
    
    /// The State Object containing the Finance the User chose to
    /// click
    @StateObject private var financeWrapperState : FinanceWrapper = FinanceWrapper()
    
    /// All the Finances that are related to this Legal
    /// Person.
    @State private var finances : [Finance] = []
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ListTile(name: "Name", data: legalPersonWrapper.legalPerson!.name!, textContentType: .name)
                    ListTile(name: "Type", data: legalPersonWrapper.legalPerson!.typeAsString())
                } header: {
                    Text("General Values")
                } footer: {
                    Text("These are the general Values for this \(legalPersonWrapper.legalPerson!.typeAsString())")
                }
                Section {
                    ListTile(name: "Phone", data: legalPersonWrapper.legalPerson!.phone!, textContentType: .telephoneNumber)
                    Text(notes)
                        .lineLimit(5...10)
                        .foregroundColor(.gray)
                } header: {
                    Text("Optional Data")
                } footer: {
                    Text("These Data are optional and you may have not added them.")
                }
                Section {
                    ForEach(finances) {
                        finance in
                        ListTile(
                            name: finance.typeAsString(),
                            data: String(Double(truncating: finance.amount!)),
                            onTap: {
                                financeWrapper.finance = finance
                                dismiss()
                            }
                        )
                    }
                } header: {
                    Text("Relations")
                } footer: {
                    Text("Represents all relations this Finance has.")
                }
            }
            .navigationTitle("\(legalPersonWrapper.legalPerson!.name!) Details")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarRole(.navigationStack)
            .toolbar(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        EditLegalPerson()
                            .environmentObject(legalPersonWrapper)
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
        .onAppear {
            let request = Finance.fetchRequest()
            request.predicate = NSPredicate(format: "legalPerson = %@", legalPersonWrapper.legalPerson!)
            finances = try! viewContext.fetch(request)
        }
    }
    
    /// Builds and returns the View representing
    /// the Homepage Field depending on
    /// the Type of the Legal Person
    @ViewBuilder
    private func homepageField() -> some View {
        if legalPersonWrapper.legalPerson is Union {
            let u : Union = legalPersonWrapper.legalPerson as! Union
            HStack {
                Text("Homepage")
                Spacer()
                if u.url != nil {
                    Link(u.url!.absoluteString, destination: u.url!)
                } else {
                    Text("No URL given")
                }
            }
        }
    }
    
    /// The Notes shown in this View.
    /// If the Notes to this Legal Person are empty,
    /// this returns an information String
    /// stating exactly that.
    private var notes : String {
        if legalPersonWrapper.legalPerson!.notes!.isEmpty {
            return "No Notes"
        } else {
            return legalPersonWrapper.legalPerson!.notes!
        }
    }
}

internal struct LegalPersonDetails_Previews: PreviewProvider {
    
    /// The preview legal Person
    private static var personWrapper : LegalPersonWrapper = LegalPersonWrapper(legalPerson: LegalPerson.anonymous)
    
    /// The preview Finance
    private static var financeWrapper : FinanceWrapper = FinanceWrapper(finance: Finance.anonymous)
    
    static var previews: some View {
        LegalPersonDetails()
            .environmentObject(personWrapper)
            .environmentObject(financeWrapper)
    }
}
