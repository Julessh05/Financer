//
//  SecureStorage.swift
//  Financer
//
//  Created by Julian Schumacher on 05.11.22 as Storage.swift
//  Renamed by Julian Schumacher on 12.11.22 to SecureStorage.swift
//

import Foundation
import Security

/// Struct securly to store, load and
/// interact with the Storage using native Keychain
internal struct SecureStorage {

    /// Loads the UserData from the Keychain
    static internal func loadUser() -> [String : String] {
        var userData : [String : String] = [ : ]
        for key in User.dictionaryKeys {
            let result : AnyObject
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecAttrLabel : key,
                kSecReturnData : true
            ]
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            guard status == errSecSuccess else {
                return [:]
            }
            userData[key] = result
        }
        return userData
    }

    /// Stores the User to the Keychain
    static internal func storeUser(user : User) -> Void {
        for data in user.toDictionary() {
            let query : [CFString : String] = [
                kSecClass : kSecClassKey as String,
                kSecAttrLabel : data.key,
                kSecValueData : data.value,
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                return
            }
        }
    }
    
    /// Deletes all Data from
    /// the local Storage
    static internal func deleteData() -> Void {
        for data in User.dictionaryKeys {
            let query : [CFString : String] = [
                kSecClass : kSecClassKey as String,
                kSecAttrLabel : data,
            ]
            let status = SecItemDelete(query as CFDictionary)
            guard status == errSecSuccess else {
                return
            }
        }

    }
}
