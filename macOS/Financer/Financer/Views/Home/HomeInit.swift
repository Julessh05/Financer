//
//  ContentView.swift
//  Financer
//
//  Created by Julian Schumacher as ContentView.swift on 29.10.22.
//
//  Renamed by Julian Schumacher to Home.swift on 08.01.23
//

import SwiftUI

/// The init view of the Home View
internal struct HomeInit: View {
    
    /// Whether the Home is selected or not
    @State private var homeSelected : Bool = true
    
    /// Whether a Finance is selected or not
    @State private var financeSelected : Bool = false
    
    /// The Finance that is currently selected
    @State private var selectedFinance : Finance? = nil
    
    /// Whether the add View is presented or not.
    @State private var addPresented : Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("General") {
                    NavigationLink {
                        Home()
                    } label: {
                        HStack {
                            Image(systemName: "house")
                                .renderingMode(.original)
                            Text("Home")
                            Spacer()
                        }
                        .padding(5)
                        .background(homeSelected ? Color.blue.opacity(0.5) : Color.clear)
                        .contentShape(Rectangle())
                        .cornerRadius(100)
                    }
                    .onTapGesture {
                        homeSelected = true
                        financeSelected = false
                        selectedFinance = nil
                    }
                }
            }
            .listStyle(.sidebar)
        } detail: {
            Home()
                .toolbarRole(.automatic)
                .toolbar(.automatic, for: .windowToolbar)
                .toolbar {
                    Spacer()
                    NavigationLink {
                        UserDetails()
                            .onAppear {
                                homeSelected = false
                                financeSelected = false
                            }
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .renderingMode(.original)
                            .foregroundColor(.black)
                    }
                    Button {
                        addPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .popover(isPresented: $addPresented) {
                        AddFinance()
                    }
                }
        }
    }
    
    /// Builds, renders and returns the Label
    /// for each Finance in the Navigation Bar
    @ViewBuilder
    private func financesLabel(_ finance : Finance) -> some View {
        NavigationLink {
            FinanceDetails(finance: selectedFinance!)
        } label: {
            HStack {
                Image(systemName: finance is Income ? "plus" : "minus")
                    .renderingMode(.original)
                Text(String(Double(2)))
                Text(String(finance.fullAmount))
                Spacer()
            }
            .padding(5)
            .background(financeSelected && selectedFinance == finance ? Color.blue.opacity(0.5) : Color.clear)
            .contentShape(Rectangle())
            .cornerRadius(100)
        }
        .onTapGesture {
            homeSelected = false
            financeSelected = true
            selectedFinance = finance
        }
    }
}

internal struct HomeInit_Previews: PreviewProvider {
    static var previews: some View {
        HomeInit()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
