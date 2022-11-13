//
//  Storage.swift
//  Financer
//
//  Created by Julian Schumacher on 13.11.22.
//

import Foundation
import SwiftUI

/// Struct to store, load and
/// interact with the Storage
internal struct Storage {
    /// Stores an Image to the local Storage
    static internal func storeImage(_ image : UIImage?) -> Void {
        if let localImage = image, let data : Data = localImage.jpegData(compressionQuality: 0.5), let path = imagePath() {
            try? data.write(to: path)
        }
    }

    /// The Path for the Document Sandbox of this App
    static private let path = {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: URL(string: ""), create: true)
    }

    /// The Path for the User Image
    static private let imagePath = {
        path()?.appendingPathExtension("userimage.jpeg")
    }
}
