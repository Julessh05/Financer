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

    /// Initializer with all Values
    internal init(name : String, lastname : String, date : Date, picture : UIImage?) {
        self.name = name
        self.lastname = lastname
        self.dateOfBirth = date
        self.picture = picture
    }

    /// Initializer for User without a Picture
    internal init(name : String, lastname : String, date : Date) {
        self.name = name
        self.lastname = lastname
        self.dateOfBirth = date
        picture = nil
    }

    /// Initializer without any Values.
    /// Can be used to create an anonymous user.
    internal init() {
        name = ""
        lastname = ""
        dateOfBirth = Date()
        picture = nil
    }

    /// Initializer when Loading this User
    /// from the Storage
    internal init(dictionary : [String : Any]) {
        for data in dictionary {
            switch data.key{
                case User.dictionaryKeys[0]:
                        name = data.value as! String
                    break;
                case User.dictionaryKeys[1]:
                    lastname = data.value as! String
                    break;
                case User.dictionaryKeys[2]:
                    dateOfBirth = data.value as! Date
                    break;
                case User.dictionaryKeys[3]:
                    picture = data.value as? UIImage
                    break;
                default:
                    break;
            }
        }
    }

    /// Whether this User is an anonymous User,
    /// or an acutal one, which the User of the App
    /// created.
    internal var isAnonymous : Bool {
        get {
            return name.isEmpty && lastname.isEmpty
        }
    }

    /// Returns this User as a Dictionary with al values.
    internal func toDictionary() -> [String : Any] {
        return [
            User.dictionaryKeys[0] : name,
            User.dictionaryKeys[1] : lastname,
            User.dictionaryKeys[2] : dateOfBirth,
            User.dictionaryKeys[3] : picture,
        ]
    }

    /// The Keys when converting the User
    /// into a Dictionary
    static internal var dictionaryKeys : [String] {
        get {
            return ["name", "lastname", "date", "picture"]
        }
    }
}
