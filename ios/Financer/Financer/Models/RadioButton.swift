//
//  RadioButton.swift
//  Financer
//
//  Created by Julian Schumacher on 16.11.22.
//

import Foundation
import SwiftUI

/// An Object to represent a single Radio Buttons Data
internal struct RadioButtonData : Identifiable {
    internal var id: UUID

    /// The Name of this Button
    internal let name : String

    /// the Image of this Button
    internal let image : Image

    init(name: String, image: Image) {
        id = UUID()
        self.name = name
        self.image = image
    }
}
