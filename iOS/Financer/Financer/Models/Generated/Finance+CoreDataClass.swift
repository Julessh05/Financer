//
//  Finance+CoreDataClass.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//
//

import Foundation
import CoreData

@objc(Finance)
public class Finance: NSManagedObject {
    
    /// The Types that are available for the Finances
    internal enum FinanceType : String, CaseIterable, Identifiable {
        // ID to conform to Identifiable
        var id : Self { self }
        
        /// The Finance is an income.
        case income
        
        /// The Finance is an expense.
        case expense
    }
    
    /// The Anonymous Finance to use in Tests and Previews
    internal static var anonymous : Finance {
        let viewContext = PersistenceController.preview.container.viewContext
        let i = Income(context: viewContext)
        i.amount = 100
        i.legalPerson = LegalPerson.anonymous
        i.notes = "Test Notes"
        i.date = Date()
        return i
    }
    
    /// The Type of this Finance in the form of a String
    /// to represent it to the User.
    internal func typeAsString(capitalized : Bool = true) -> String {
        return self is Income ? (capitalized ? "Income" : "income") : (capitalized ? "Expense" : "expense")
    }
    
    /// The Direction of the Money flow with this
    /// Finance represented as a String to display it
    /// in the UI.
    internal var directionAsString : String {
        return self is Income ? "From" : "To"
    }
}
