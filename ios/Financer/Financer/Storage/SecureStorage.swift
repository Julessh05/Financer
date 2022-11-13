//
//  SecureStorage.swift
//  Financer
//
//  Created by Julian Schumacher on 05.11.22 as Storage.swift
//  Renamed by Julian Schumacher on 12.11.22 to SecureStorage.swift
//

import Foundation
import Security

/// Struct to store, load and
/// interact with the Storage
internal struct SecureStorage {
    
    /// Loads all the Data from
    /// the local Storage
    static internal func load() -> LoadResult {
        return LoadResult(user: loadUser())
    }

    static private func loadUser() -> User {
        var userData : [String : Any] = [ : ]

        for key in User.dictionaryKeys {
            let result : CFTypeRef?
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecAttrLabel : key,
                kSecReturnData : true
            ]
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            guard status == errSecSuccess else {
                return User();
            }
            userData[key] = result
        }
        
    }
    
    /// Stores all the Data to
    /// the local Storage
    static internal func store(user : User) -> Void {
        storeUser(user: user)
    }

    static private func storeUser(user : User) -> Void {
        for data in user.toDictionary() {
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecAttrLabel : data.key,
                kSecValueData : data.value,
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            guard status == errSecSuccess else {
                return;
            }
        }
    }
    
    /// Deletes all Data from
    /// the local Storage
    static internal func eraseAllData() -> Void {
        
        // Close app
        exit(0)
    }
}
