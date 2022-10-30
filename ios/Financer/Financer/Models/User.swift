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
    internal let picture : UIImage
}
