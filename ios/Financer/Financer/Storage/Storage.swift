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

    /// The UserDefaults used to store Values
    static private let userDefaults : UserDefaults = UserDefaults.standard

    /// Stores an Image to the local Storage
    static internal func storeImage(_ image : UIImage?) -> Void {
        if let data : Data = image?.jpegData(compressionQuality: 0.5), let path = imagePath() {
            try? data.write(to: path)
        }
    }

    /// Loads the User Image from the File it was safed to
    static internal func loadUserImage() -> UIImage? {
        guard let path = imagePath(), let data : Data = FileManager.default.contents(atPath: path.path()) else {
            return nil
        }
        return UIImage(data: data)
    }

    /// The Path for the Document Sandbox of this App
    static private let path = {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: URL(string: ""), create: true)
    }

    /// The Path for the User Image
    static private let imagePath = {
        path()?.appendingPathExtension("userimage.jpeg")
    }

    /// deletes the Image from the File System
    static internal func deleteImage() -> Void {
        if let path = imagePath() {
            try? FileManager.default.removeItem(at: path)
        }
    }

    /// Deletes all Data stored by this App.
    /// It deletes the unencrypted Files like the User Image, all
    /// Files with Information as well as everything in the UserDefaults,
    /// all encrypted Files and all encrypted Data stored
    /// in the Keychain
    static internal func eraseAllData() -> Void {
        SecureStorage.deleteData()
        deleteImage()
        exit(0)
    }

    static internal func loadAllData() -> Void {
        SecureStorage.loadLegalPersons()
        SecureStorage.loadFinances()
    }
}
