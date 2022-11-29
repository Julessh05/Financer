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
    internal static func loadUser() -> [String : String] {
        var userData : [String : String] = [ : ]
        for key in User.dictionaryKeys {
            var result : AnyObject?
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecAttrLabel : key,
                kSecReturnData : true
            ]
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            guard status == errSecSuccess else {
                return [ : ]
            }
            userData[key] = result as? String
        }
        return userData
    }

    /// Stores the User to the Keychain
    internal static func storeUser(user : User) -> Void {
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

    /// Loads all the Finances from the Keychain
    /// and matches the Finances to the Finances List
    internal static func loadFinances() -> Void {

    }

    /// Saves all the Finances to the Keychain
    internal static func storeFinances() -> Void {
        var list : [Data] = []
        for finance in FinanceList.instance.items {
            if let encoded : Data = try? JSONEncoder().encode(finance) {
                list.append(encoded)
            }
        }

        for finance in list {
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecAttr
            ]
        }
    }

    /// Loads all the Legal Persons from the Keychain
    /// and matches the Persons to the Persons List
    internal static func loadLegalPersons() -> Void {

    }

    /// Saves all the Legal Persons to the Keychain
    internal static func storeLegalPersons() -> Void {
        var list : [Data] = []
        for legalPerson in LegalPersonList.instance.items {
            if let encoded : Data = try? JSONEncoder().encode(legalPerson) {
                list.append(encoded)
            }
        }
    }

    /// Deletes all Data from
    /// the local Storage
    internal static func deleteData() -> Void {
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
