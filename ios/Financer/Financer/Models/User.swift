//
//  User.swift
//  Financer
//
//  Created by Julian Schumacher on 30.10.22.
//

import Foundation
import UIKit

/// The Struct that represents a
/// single User and all their Information
/// in this App.
internal struct User {

    /// The first Name of this User
    internal let name : String

    /// The last Name of this User
    internal let lastname : String

    /// Their Date of Birth
    internal let dateOfBirth : Date

    /// The "Profile Picture" of this User.
    internal let picture : UIImage?

    /// Initializer without any Values.
    /// Can be used to create an anonymous user.
    internal init() {
        let userData : [String : String] = SecureStorage.loadUser()
        var localName : String = ""
        var localLastname : String = ""
        var localDate : String = ""
        for data in userData {
            switch data.key {
                case User.dictionaryKeys[0]:
                    localName = data.value
                    break
                case User.dictionaryKeys[1]:
                    localLastname = data.value
                    break
                case User.dictionaryKeys[2]:
                    localDate = data.value
                    break
                default:
                    break
            }
        }
        name = localName
        lastname = localLastname
        dateOfBirth = ISO8601DateFormatter().date(from: localDate) ?? Date()
        picture = Storage.loadUserImage()
    }


    /// Initializer with all Values
    internal init(name : String, lastname : String, date : Date, picture : UIImage?) {
        self.name = name
        self.lastname = lastname
        self.dateOfBirth = date
        self.picture = picture
    }

    /// Whether this User is an anonymous User,
    /// or an acutal one, which the User of the App
    /// created.
    internal var isAnonymous : Bool {
        get {
            name.isEmpty && lastname.isEmpty
        }
    }

    /// Returns this User as a Dictionary with al values.
    internal func toDictionary() -> [String : String] {
        return [
            User.dictionaryKeys[0] : name,
            User.dictionaryKeys[1] : lastname,
            User.dictionaryKeys[2] : dateOfBirth.ISO8601Format(.iso8601),
        ]
    }

    /// The Keys when converting the User
    /// into a Dictionary
    static internal var dictionaryKeys : [String] {
        get {
            return ["name", "lastname", "date"]
        }
    }
}
