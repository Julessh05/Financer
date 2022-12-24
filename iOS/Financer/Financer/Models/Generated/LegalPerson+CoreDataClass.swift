//
//  LegalPerson+CoreDataClass.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//
//

import Foundation
import CoreData

@objc(LegalPerson)
public class LegalPerson: NSManagedObject {
    
    /// Enumeration to represent the Type of the Legal Person.
    internal enum LegalPersonType : String, Identifiable, CaseIterable {
        // ID to conform to identifiable
        var id: Self { self }
        
        /// The Legal Person is an actual living Person
        case person
        
        /// The Legal Person is a Company
        case company
        
        /// The Legal Person is an Organization
        case organization
        
        /// No Value selected
        case none
    }
    
}
