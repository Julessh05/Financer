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
    
    // TODO: implement
    internal enum Gender : String, CaseIterable {
        
        case notEntered

        case male

        case female

        case nonbinary
        
        case ownEntered
    }
    
    /// The Anonymous User to use in Tests and Previews
    internal static var anonymous : User {
        let viewContext = PersistenceController.preview.container.viewContext
        let u = User(context: viewContext)
        u.firstname = "Julian"
        u.lastname = "Schumacher"
        u.dateOfBirth = Date()
        return u
    }

}
