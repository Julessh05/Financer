//
//  Displayable.swift
//  Financer
//
//  Created by Julian Schumacher on 20.11.22.
//

import Foundation

/// The Protocol an Object can to conform
/// to, to be displayable in the UI
internal protocol Displayable {
    /// The Name to be displayed as a String
    var name : String { get }
}
