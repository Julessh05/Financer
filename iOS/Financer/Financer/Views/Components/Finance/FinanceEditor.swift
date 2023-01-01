//
//  FinanceEditor.swift
//  Financer
//
//  Created by Julian Schumacher on 01.01.23.
//

import SwiftUI

/// The Editor to 
internal struct FinanceEditor: View {
    
    /// The dismiss Action to dismiss this View.
    ///
    /// This is used, because this view is presented as a sheet or popover.
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    /// The Context to interact with Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The Text of the "Amount" Textfield
    @State private var amount : String = ""
    
    /// The Legal Person connected to this Finance
    @State private var legalPerson : LegalPerson?
    
    /// The Date this Finance referes to
    @State private var date : Date = Date()
    
    /// The Notes to this Finance
    @State private var notes : String = ""
    
    /// Whether the Button is active (all Fields are enter validly) or
    /// not.
    @State private var btnActive : Bool = false
    
    /// Whether ther Error for missing Arguments is displayed or not.
    @State private var errMissingArgumentsPresented : Bool = false
    
    /// The Type of this Finance
    @State private var financeType : Finance.FinanceType = .income
    
    /// The callback to execute when the Editor is done.
    /// The Arguments are in this order:
    /// Double - amount
    /// LegalPerson - legalPerson
    /// String - notes
    /// Date - date
    /// Finance.FinanceType - financeType
    private let callback : (Finance) -> Void
    
    /// The initializer to add a new Finance
    internal init(
        action : @escaping (Finance) -> Void
    ) {
        callback = action
    }
    
    /// The Initilizer to edit a Finance
    internal init(
        action : @escaping (Finance) -> Void,
        finance : Finance
    ) {
        callback = action
        _amount = State(initialValue: String(finance.amount))
        _legalPerson = State(initialValue: finance.legalPerson!)
        _notes = State(initialValue: finance.notes!)
        _date = State(initialValue: finance.date!)
    }
    
    var body: some View {
        GeometryReader {
            metrics in
            VStack {
                Picker("Type", selection: $financeType) {
                    ForEach(Finance.FinanceType.allCases) {
                        fT in
                        Text(fT.rawValue.capitalized)
                    }
                }
                .padding(.horizontal, 10)
                .pickerStyle(.segmented)
                Form {
                    Section {
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                            .textInputAutocapitalization(.never)
                            .onSubmit { checkBtn() }
                        NavigationLink {
                            LegalPersonPicker(
                                legalPerson: $legalPerson
                            )
                        } label: {
                            legalPersonNavigationLabel()
                        }
                    } header: {
                        Text("Required Information")
                    } footer: {
                        Text("It's required to enter these Information.")
                    }
                    Section {
                        TextField("Notes", text: $notes, axis: .vertical)
                            .lineLimit(5...10)
                            .keyboardType(.asciiCapable)
                            .textInputAutocapitalization(.sentences)
                        DatePicker(
                            "Date",
                            selection: $date,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(.graphical)
                    } header: {
                        Text("Optional Data")
                    } footer: {
                        VStack(alignment: .leading) {
                            Text("If you want to customize these Data, you can do so here.")
                            Text("Otherwise these Data will be inserted automatically.")
                        }
                    }
                }
                Button(action: action) {
                    Label(
                        "Save",
                        systemImage: "square.and.arrow.down"
                    )
                    .frame(
                        width: metrics.size.width / 1.2,
                        height: metrics.size.height / 15
                    )
                    .foregroundColor(.white)
                    .background(btnActive ? Color.blue : Color.gray)
                    .cornerRadius(20)
                }
                .alert(
                    "Missing Data",
                    isPresented: $errMissingArgumentsPresented
                ) {
                } message: {
                    Text("Please enter all required Data before you continue")
                }
            }
        }
        .onAppear { checkBtn() }
        .textFieldStyle(.plain)
        .formStyle(.grouped)
        .toolbarRole(.navigationStack)
        .toolbar(.automatic, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                   action()
                }
            }
        }
    }
    
    /// Builds and returns the label
    /// connected to the navigation Link which
    /// points to the Legal Person Picker
    @ViewBuilder
    private func legalPersonNavigationLabel() ->
    HStack<TupleView<(Text, Spacer, Text)>> {
        HStack {
            Text(financeType == .income ? "From" : "To")
            Spacer()
            Text(legalPerson?.name! ?? "None")
                .foregroundColor(.gray)
        }
    }
    
    /// Validates the Amount and formats the amount to
    /// provide more luxury and comfortability to the User.
    /// This returns the formatted amount
    private func validateAmount() -> String {
        var result : String = amount
        while result.components(separatedBy: ".")[0].count > 2 {
            result.removeLast()
        }
        if amount.starts(with: ".") || amount.starts(with: ",") {
            return "0\(amount)"
        } else {
            return amount
        }
    }
    
    /// Checks if the required Values are entered, and if so
    /// activates the Button.
    private func checkBtn() -> Void {
        btnActive = !amount.isEmpty && legalPerson != nil
    }
    
    /// The action executed when the Save or Done Button
    /// is clicked
    private func action() -> Void {
        let finance : Finance
        if financeType == .income {
            finance = Income(context: viewContext)
        } else {
            finance = Expense(context: viewContext)
        }
        finance.amount = Double(validateAmount())!
        finance.legalPerson = legalPerson
        finance.notes = notes
        finance.date = date
        callback(finance)
        dismiss()
    }
}

internal struct FinanceEditor_Previews: PreviewProvider {
    static var previews: some View {
        FinanceEditor(action: a)
    }
    
    /// The action to use in this preview.
    private static func a(
        finance : Finance
    ) -> Void {
        print("Preview Button pressed")
    }
}
