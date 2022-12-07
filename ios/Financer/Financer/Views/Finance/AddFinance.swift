//
//  AddFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 15.11.22.
//

import SwiftUI

/// The View to add a new Finance
/// to this App
internal struct AddFinance: View {

    /// The Type of this Finance
    @State private var financeType : Finance.FinanceType = .income

    /// The Amount of this Finance
    @State private var amount : String = ""

    /// The Type of legal Person this
    /// Finance is connected to
    @State private var legalPerson : LegalPerson?

    /// Whether the "Add Finance" Button is Active or not
    @State private var btnActive : Bool = false

    /// Action to dismiss this View
    @Environment(\.dismiss) private var dismiss : DismissAction

    /// Whether this Screen is in edit Mode
    /// or not
    private let edit : Bool

    /// The Finance to edit.
    private var finance : Binding<Finance>?

    /// Initializer to add a Finance
    internal init() {
        edit = false
        finance = nil
    }

    /// Initializer to edit the passed finance
    internal init(finance : Binding<Finance>) {
        edit = true
        self.finance = finance
        _financeType = State(initialValue: finance.wrappedValue.type)
        _amount = State(initialValue: String(finance.wrappedValue.amount))
        _legalPerson = State(initialValue: finance.wrappedValue.legalPerson)
    }

    var body: some View {
        GeometryReader { metrics in
            VStack {
                Form {
                    Section {
                        Picker("Type", selection: $financeType) {
                            ForEach(Finance.FinanceType.allCases) {
                                c in
                                Text(c.rawValue.capitalized)
                            }
                        }
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.plain)
                            .onSubmit {
                                checkBtn()
                            }
                    } header: {
                        Text("Type")
                    } footer: {
                        Text("The Amount of Money transfered with this Finance")
                    }
                    Section {
                        NavigationLink(destination: LegalPersonPicker(legalPerson: $legalPerson)) {
                            DetailLabel(title: "Legal Person", data: legalPerson?.name ?? "None")
                        }
                    } header: {
                        Text("Relation")
                    } footer: {
                        Text("The Relation of this Finance")
                    }
                }
                Button {
                    btnActive ? addFinance() : nil
                } label: {
                    Spacer()
                    Label("Save", systemImage: "square.and.arrow.down")
                        .frame(width: metrics.size.width / 1.2,
                               height: metrics.size.height / 15)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                    Spacer()
                }
            }
        }.onAppear(perform: checkBtn)
            .navigationTitle("Add Finance")
            .navigationBarTitleDisplayMode(.automatic)
    }

    /// Adds the Finance to the
    /// FinanceList
    private func addFinance() -> Void {
        let finance : Finance
        if financeType == .income {
            finance = Income(amount: Double(amount)!,
                             legalPerson: legalPerson!)
        } else {
            finance = Expense(amount: Double(amount)!,
                              legalPerson: legalPerson!)
        }
        if edit {
            FinanceList.instance.replace(toReplace: self.finance!.wrappedValue, replace: finance)
        } else {
            FinanceList.instance.add(item: finance)
        }
        dismiss()
    }

    /// Checks if the Button should be active
    /// To enable the Button, all required Values
    /// must be entered
    private func checkBtn() -> Void {
        btnActive = !amount.isEmpty && legalPerson != nil
    }
}

internal struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
