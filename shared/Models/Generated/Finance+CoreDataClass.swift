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
    
    internal enum PaymentDuration : String, CaseIterable, Identifiable {
        // ID to conform to Identifiable
        var id: Self { self }
        
        internal init(days : Int) {
            switch days {
            case 1:
                self = .daily
            case 7:
                self = .weekly
            case 31:
                self = .monthly
            case 365:
                self = .yearly
            default:
                self = .monthly
            }
        }
        
        /// The Payment is due every day
        case daily
        
        /// The payment is due every week
        case weekly
        
        /// The payment is due every month
        case monthly
        
        /// The payment is due every year
        case yearly
        
        /// Returns the days depending on the
        /// chosen Enum
        var days : Int {
            switch self {
            case .daily:
                return 1
            case .weekly:
                return 7
            case .monthly:
                return 31
            case .yearly:
                return 365
            }
        }
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
    
    /// Returns the amount of this Finance as a signed
    /// Double Value. Expenses are negative
    internal var singnedAmount : NSDecimalNumber {
        self is Income ? amount! : amount!.multiplying(by: -1)
    }
    
    /// Returns the Amount as a displayable Double Value
    internal var displayableAmount : Double {
        amount!.doubleValue
    }
    
    internal var fullAmount : String {
        String(format: "%.2f\(Locale.current.currencySymbol!)", displayableAmount)
    }
    
    /// The Direction of the Money flow with this
    /// Finance represented as a String to display it
    /// in the UI.
    internal var directionAsString : String {
        self is Income ? "From" : "To"
    }
    
    /// Returns a Boolean indicating if this
    /// Finance is a periodical Finance or not.
    internal var isPeriodical : Bool {
        periodDuration != 0
    }
}
