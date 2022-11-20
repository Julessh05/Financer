//
//  ModelsList.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation
import SwiftUI

/// Model for all the Lists that are used to store properties.
internal class ModelsList<T> : ModelsListProtocol where T : Equatable, T : Identifiable {

    internal typealias ModelsListType = T

    internal var items: [T] = []

    internal func add(item: T) -> Void {
        items.append(item)
    }

    internal func add(items localItems: [T]) {
        items.append(contentsOf: localItems)
    }

    internal func delete(item: T) -> Void {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }

    internal func delete(items localItems: [T]) -> Void {
        for item in localItems {
            if let index = items.firstIndex(of: item) {
                items.remove(at: index)
            }
        }
    }
}
