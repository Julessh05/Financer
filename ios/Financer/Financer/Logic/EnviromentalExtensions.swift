//
//  EnviromentalExtensions.swift
//  Financer
//
//  Created by Julian Schumacher on 05.11.22.
//

import Foundation
import SwiftUI

/// The Key for the Environment Value that
/// represents the current User
private struct UserKey : EnvironmentKey {
    static let defaultValue: User = User()

}

/// Extension on the EnvironmentValues to provide
/// the current User to the Environment.
internal extension EnvironmentValues {
    /// The current User of this App.
    /// The defaultValue of this Environmental
    /// Value is an empty User.
    var currentUser : User {
        get { self[UserKey.self] }
        set { self[UserKey.self] = newValue }
    }
}
