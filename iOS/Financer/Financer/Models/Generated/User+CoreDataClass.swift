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
    internal enum Gender : CaseIterable, Hashable {
        
        /// All the Cases shown in a for Each.
        /// This is manually implemented because not all values are shown
        /// here
        static var allCases : [User.Gender] {
            return [none, male, female, nonbinary, useOwnValue]
        }
        
        /// The Value as a String to
        /// display in the UI
        var stringValue : String {
            switch self {
                case .male:
                    return "Male"
                case .female:
                    return "Female"
                case .nonbinary:
                    return "Non Binary"
                case .none:
                    return "None"
                case .useOwnValue:
                    return "Use Custom"
                default:
                    return "No Value"
            }
        }
        
        /// No Value was entered
        case none

        /// The User is a man
        case male

        /// The User is a women
        case female

        /// The User does not identify
        /// as binary (neither male nor female)
        case nonbinary
        
        /// The Enum Case is used to indicate to the
        /// UI Screen, that the User wants to enter
        /// a Value himself.
        case useOwnValue
        
        /// The User entered it's own gender identification
        case ownEntered(entered : String)
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
