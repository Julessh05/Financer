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

    /// The first Name of this User
    internal let name : String

    /// The last Name of this User
    internal let lastname : String

    /// Their Date of Birth
    internal let dateOfBirth : Date

    /// The "Profile Picture" of this User.
    internal let picture : UIImage?
}
