//
//  AddFinance.swift
//  Financer
//
//  Created by Julian Schumacher on 22.02.23.
//

import SwiftUI

/// This is the View to add a new Finance.
internal struct AddFinance: View {
    
    /// The Amount entered in the corresponding Textfield
    @State private var amount : String = ""
    
    /// The Type of Finance
    @State private var type : Finance.FinanceType = .income
    
    /// The Legal Person this payment went to / came from
    @State private var legalPerson : LegalPerson?
    
    /// The Notes corresponding to the Finance
    @State private var notes : String = ""
    
    /// The Date of the Finance
    @State private var date : Date = Date()
    
    /// Whether this is a peridocial Payment or not
    @State private var isPeriodicalPayment : Bool = false
    
    /// The Duration of the periodical payment
    @State private var periodDuration : Finance.PaymentDuration = .monthly
    
    var body: some View {
        VStack {
            TextField("amount", text: $amount)
                .textFieldStyle(.squareBorder)
        }
    }
}

internal struct AddFinance_Previews: PreviewProvider {
    static var previews: some View {
        AddFinance()
    }
}
