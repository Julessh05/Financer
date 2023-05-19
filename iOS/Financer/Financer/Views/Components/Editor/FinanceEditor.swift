//
//  FinanceEditor.swift
//  Financer
//
//  Created by Julian Schumacher on 01.01.23.
//

import SwiftUI

/// The Editor to edit Finances
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
    
    /// If this is true, the Error Message stating that the Input into the
    /// amount field has the wrong type
    @State private var errWrongInputType : Bool = false
    
    /// The Type of this Finance
    @State private var financeType : Finance.FinanceType = .income
    
    /// Whether this Finance is a periodical payment or not
    @State private var isPeriodicalPayment : Bool = false
    
    /// The Duration of the periodical payment
    @State private var periodDuration : Finance.PaymentDuration = .monthly
    
    /// The callback to execute when the Editor is done.
    /// The Arguments are in this order:
    private let callback : (Finance) -> Void
    
    /// The initializer to add or edit a Finance.
    /// If you pass a finance, it will be edited, otherwise,
    /// a new Finance is added.
    internal init(
        action : @escaping (Finance) -> Void,
        finance : Finance? = nil
    ) {
        callback = action
        if finance != nil {
            _financeType = State(initialValue: Finance.FinanceType(rawValue: finance!.typeAsString(capitalized: false))!)
            _amount = State(initialValue: finance!.amount!.stringValue)
            _legalPerson = State(initialValue: finance!.legalPerson!)
            _notes = State(initialValue: finance!.notes!)
            _date = State(initialValue: finance!.date!)
            if finance!.isPeriodical {
                _isPeriodicalPayment = State(initialValue: true)
                _periodDuration = State(initialValue: Finance.PaymentDuration(days: Int(finance!.periodDuration)))
            }
        }
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
                            .onChange(of: amount) {
                                _ in
                                checkBtn()
                            }
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
                        periodicalPaymentSection()
                        datePickerSection()
                        TextField("Notes", text: $notes, axis: .vertical)
                            .lineLimit(5...10)
                            .keyboardType(.asciiCapable)
                            .textInputAutocapitalization(.sentences)
                    } header: {
                        Text("Optional Data")
                    } footer: {
                        VStack(alignment: .leading) {
                            Text("If you want to customize these Data, you can do so here.")
                            Text("Otherwise these Data will be inserted automatically.")
                        }
                    }
                }
                .alert(
                    "Missing Data",
                    isPresented: $errMissingArgumentsPresented
                ) {
                } message: {
                    Text("Please enter all required Data before you continue")
                }
                .alert(
                    "False Data",
                    isPresented: $errWrongInputType
                ) {
                } message: {
                    Text("Please do only enter numbers into the amount field")
                }
            }
        }
        .onAppear { checkBtn() }
        .textFieldStyle(.plain)
        .formStyle(.grouped)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden()
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
    
    /// Builds, renders and returns the Section for the
    /// Date Picker
    private func datePickerSection() -> some View {
        let displayComponents : DatePickerComponents
        if isPeriodicalPayment {
            displayComponents = [.date]
        } else {
            displayComponents = [.date, .hourAndMinute]
        }
        return DatePicker(
            "Date",
            selection: $date,
            displayedComponents: displayComponents
        )
        .datePickerStyle(.graphical)
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
    
    
    
    /// Renders, builds and returns the section
    /// to enter the periodical payment info, if this Finance is so.
    @ViewBuilder
    private func periodicalPaymentSection() -> some View {
        Toggle("Periodical Payment", isOn: $isPeriodicalPayment.animation())
        if isPeriodicalPayment {
            Picker("Payment Period", selection: $periodDuration) {
                ForEach(Finance.PaymentDuration.allCases) {
                    duration in
                    Text(duration.rawValue.capitalized)
                }
            }
            .pickerStyle(.wheel)
        }
    }
    
    /// Validates the Amount and formats the amount to
    /// provide more luxury and comfortability to the User.
    /// This returns the formatted amount
    private func validateAmount() -> String {
        var result : String = amount
        result = result.replacingOccurrences(of: ",", with: ".")
        guard result.contains(".") else {
            return result
        }
        while result.components(separatedBy: ".").count > 2 {
            result.removeLast()
        }
        while result.components(separatedBy: ".")[1].count > 2 {
            result.removeLast()
        }
        if result.starts(with: ".") {
            result = "0.\(result)"
        }
        return result
    }
    
    /// Checks if the required Values are entered, and if so
    /// activates the Button.
    private func checkBtn() -> Void {
        btnActive = !amount.isEmpty && legalPerson != nil
    }
    
    /// The action executed when the Save or Done Button
    /// is clicked
    private func action() -> Void {
        if btnActive {
            let finance : Finance
            if financeType == .income {
                finance = Income(context: viewContext)
            } else {
                finance = Expense(context: viewContext)
            }
            finance.amount = NSDecimalNumber(string: validateAmount())
            finance.legalPerson = legalPerson
            finance.notes = notes
            if isPeriodicalPayment {
                let calendar : Calendar = Calendar.current
                finance.periodDuration = Int16(periodDuration.days)
                let odc : DateComponents = calendar.dateComponents([.year, .month, .day], from: date)
                let ndc : DateComponents = DateComponents(
                    year: odc.year,
                    month: odc.month,
                    day: odc.day,
                    hour: 0,
                    minute: 0,
                    second: 0
                )
                finance.date = calendar.date(from: ndc)
            } else {
                finance.date = date
            }
            callback(finance)
            dismiss()
        } else {
            errMissingArgumentsPresented.toggle()
        }
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
