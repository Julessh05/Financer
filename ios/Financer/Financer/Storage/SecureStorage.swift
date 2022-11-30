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

            if status == errSecDuplicateItem {
                let updateQuery : [CFString : String] = [
                    kSecValueData : data.value
                ]
                SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            }
            guard status == errSecSuccess else {
                return
            }
        }
    }

    /// Loads all the Finances from the Keychain
    /// and matches the Finances to the Finances List
    internal static func loadFinances() -> Void {
        let ids : [UUID] = loadKeys(for: Finance.self)
        for id in ids {
            var result : AnyObject?
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecReturnData : true,
                kSecAttrLabel : id,
            ]
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            guard status == errSecSuccess else {
                return
            }
            FinanceList.instance.add(item: result as! Finance)
        }
    }

    /// Saves all the Finances to the Keychain
    internal static func storeFinances() -> Void {
        var list : [UUID : Data] = [:]
        for finance in FinanceList.instance.items {
            if let encoded : Data = try? JSONEncoder().encode(finance) {
                list[finance.id] = encoded
            }
        }
        storeKeys(for: Finance.self)

        for finance in list {
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecValueData : finance.value,
                kSecAttrLabel: finance.key,
                kSecReturnData : false,
                kSecMatchLimit : kSecMatchLimitOne
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            if status == errSecDuplicateItem {
                let updateQuery : [CFString : Data] = [
                    kSecValueData : finance.value
                ]
                SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            }
            guard status == errSecSuccess else {
                return
            }
        }
    }

    /// Loads all the Legal Persons from the Keychain
    /// and matches the Persons to the Persons List
    internal static func loadLegalPersons() -> Void {
        let ids : [UUID] = loadKeys(for: LegalPerson.self)
        for id in ids {
            var result : AnyObject?
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecReturnData : true,
                kSecAttrLabel : id,
            ]
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            guard status == errSecSuccess else {
                return
            }
            LegalPersonList.instance.add(item: result as! LegalPerson)
        }
    }

    /// Saves all the Legal Persons to the Keychain
    internal static func storeLegalPersons() -> Void {
        var list : [UUID : Data] = [:]
        for legalPerson in LegalPersonList.instance.items {
            if let encoded : Data = try? JSONEncoder().encode(legalPerson) {
                list[legalPerson.id] = encoded
            }
        }

        storeKeys(for: LegalPerson.self)

        for legalPerson in list {
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecValueData : legalPerson.value,
                kSecAttrLabel : legalPerson.key,
                kSecReturnData : false,
                kSecMatchLimit : kSecMatchLimitOne
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            if status == errSecDuplicateItem {
                let updateQuery : [CFString : Data] = [
                    kSecValueData : legalPerson.value
                ]
                SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            }
            guard status == errSecSuccess else {
                return
            }
        }
    }

    /// The Key for the Finance ID's stored in the Keychain
    private static let financeIDKeys : String = "Finance ID's"

    /// Loads all the Keys for the Finances from the Keychain
    private static func loadKeys(for type : Finance.Type) -> [UUID] {
        var result : AnyObject?
        let query : [CFString : Any] = [
            kSecClass : kSecClassKey,
            kSecAttrLabel : financeIDKeys,
            kSecReturnData : true
        ]
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else {
            return []
        }
        let data : Data = result as! Data
        return NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: [UUID].self, from: data) as! [UUID]
    }

    /// Stores all the Keys for the Finances to the Keychain
    private static func storeKeys(for type : Finance.Type) -> Void {
        var list : [UUID] = []
        for finance in FinanceList.instance.items {
            list.append(finance.id)
        }

        if let data : Data = try? NSKeyedArchiver.archivedData(withRootObject: list, requiringSecureCoding: true) {
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecValueData : data,
                kSecAttrLabel : financeIDKeys
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            if status == errSecDuplicateItem {
                let updateQuery : [CFString : Data] = [
                    kSecValueData : data
                ]
                SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            }
            guard status == errSecSuccess else {
                return
            }
        } else {
            return
        }
    }

    /// The Key for the Legal Person ID's stored in the Keychain
    private static let legalPersonIDKeys : String = "Legal Person ID's"

    /// Loads all the Keys for the Legal Persons from the Keychain
    private static func loadKeys(for type : LegalPerson.Type) -> [UUID] {
        var result : AnyObject?
        let query : [CFString : Any] = [
            kSecClass : kSecClassKey,
            kSecAttrLabel : legalPersonIDKeys,
            kSecReturnData : true
        ]
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else {
            return []
        }
        return result as! [UUID]
    }

    /// Stores all the Keys for the Legal Persons to the Keychain
    private static func storeKeys(for type : LegalPerson.Type) -> Void {
        var list : [UUID] = []
        for legalPerson in FinanceList.instance.items {
            list.append(legalPerson.id)
        }

        if let data : Data = try? NSKeyedArchiver.archivedData(withRootObject: list, requiringSecureCoding: true) {
            let query : [CFString : Any] = [
                kSecClass : kSecClassKey,
                kSecValueData : data,
                kSecAttrLabel : legalPersonIDKeys
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            if status == errSecDuplicateItem {
                let updateQuery : [CFString : Data] = [
                    kSecValueData : data
                ]
                SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            }
            guard status == errSecSuccess else {
                return
            }
        } else {
            return
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
