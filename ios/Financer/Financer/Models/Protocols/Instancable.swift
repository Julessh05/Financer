//
//  Instancable.swift
//  Financer
//
//  Created by Julian Schumacher on 19.11.22.
//

import Foundation

/// Makes an Object Instancable,
/// so that you can have an Instance, with
/// instance methods, but still an kind of
/// static access to it.
internal protocol Instancable {
    /// The Instance of this Object
    static var instance : Self { get }
}
