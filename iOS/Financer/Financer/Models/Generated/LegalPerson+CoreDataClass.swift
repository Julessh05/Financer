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
        
        /// No Value selected
        case none
        
        /// The Legal Person is an actual living Person
        case person
        
        /// The Legal Person is a Company
        case company
        
        /// The Legal Person is an Organization
        case organization
    }
    
    /// The Anonymous Legal Person to use in Tests and Previews
    internal static var anonymous : LegalPerson {
        let viewContext = PersistenceController.preview.container.viewContext
        let p = Person(context: viewContext)
        p.name = "Julian Schumacher"
        p.phone = "+123456789"
        p.notes = "Test Notes"
        return p
    }
    
    /// The Type of this Legal Person represented as
    /// a String to display it in the UI and show it to the User.
    internal var typeAsString : String {
        switch self {
            case is Person:
                return "Person"
            case is Company:
                return "Company"
            case is Organization:
                return "Organization"
            default:
                return "Unknown"
        }
    }
}
