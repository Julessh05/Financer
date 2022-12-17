//
//  LegalPersonList.swift
//  Financer
//
//  Created by Julian Schumacher on 21.11.22.
//

import Foundation

/// The List that holds all the Legal Persons
internal struct LegalPersonList : ModelsList {

    static var instance : LegalPersonList = LegalPersonList()

    typealias ModelsListType = LegalPerson

    var items: [LegalPerson] = []

    mutating func add(item: LegalPerson) {
        items.append(item)
    }

    mutating func add(items localItems: [LegalPerson]) {
        items.append(contentsOf: localItems)
    }

    mutating func replace(toReplace: LegalPerson, replace: LegalPerson) {
        if let index = items.firstIndex(of: toReplace) {
            items[index] = replace
        }
    }

    mutating func delete(item: LegalPerson) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }

    mutating func delete(items localItems: [LegalPerson]) {
        for item in localItems {
            delete(item: item)
        }
    }
}
