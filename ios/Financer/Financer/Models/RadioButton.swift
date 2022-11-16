//
//  RadioButton.swift
//  Financer
//
//  Created by Julian Schumacher on 16.11.22.
//

import Foundation
import SwiftUI

/// A single Radio Button Representation
internal struct RadioButton : Identifiable {
    var id: UUID

    /// The Name of this Button
    let name : String

    /// the Image of this Button
    let image : Image

    /// Whether this Item
    /// is selected or not
    var selected : Bool

    init(name: String, image: Image) {
        id = UUID()
        self.name = name
        self.image = image
        selected = false
    }
}
