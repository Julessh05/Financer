//
//  FinanceList.swift
//  Financer
//
//  Created by Julian Schumacher on 21.11.22.
//

import Foundation

/// The Models that holds all the Finances
internal struct FinanceList : ModelsList {

    static var instance : FinanceList = FinanceList()

    typealias ModelsListType = Finance

    var items: [Finance] = []

    mutating func add(item: Finance) {
        items.append(item)
    }

    mutating func add(items localItems: [Finance]) {
        items.append(contentsOf: localItems)
    }

    mutating func replace(toReplace: Finance, replace: Finance) {
        if let index = items.firstIndex(of: toReplace) {
            items[index] = replace
        }
    }

    mutating func delete(item: Finance) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }


    mutating func delete(items localItems: [Finance]) {
        for item in localItems {
            delete(item: item)
        }
    }
}
