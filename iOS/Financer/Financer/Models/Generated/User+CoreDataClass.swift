//
//  User+CoreDataClass.swift
//  Financer
//
//  Created by Julian Schumacher on 07.01.23.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    /// All the possible Gender for the User to select
    internal enum Gender : String, CaseIterable, Hashable, Identifiable {
        // ID to conform to Identifiable
        var id : Self { self }
        
        /// No Value was entered
        case none

        /// The User is a man
        case male

        /// The User is a women
        case female

        /// The User does not identify
        /// as binary (neither male nor female)
        case nonbinary
    }
    
    /// The Anonymous User to use in Tests and Previews
    internal static var anonymous : User {
        let viewContext = PersistenceController.preview.container.viewContext
        let u = User(context: viewContext)
        u.firstname = "Julian"
        u.lastname = "Schumacher"
        u.dateOfBirth = Date()
        u.gender = Gender.male.rawValue
        return u
    }

}
