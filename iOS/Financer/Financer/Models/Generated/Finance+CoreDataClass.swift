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

}
