//
//  ModelsList.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation

/// Model for all the Lists that are used to store properties.
internal class ModelsList<T> : ModelsListProtocol where T : Equatable {

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

    /// Returns the List for the specified Type T
    internal static func list<T>() -> ModelsList<T> {
        assert(legalPersonType != .none, "The Type passed to this Function cannot be .none")
        switch T.self {
            case is Person.Type:
                return PersonList() as ModelsList<T>
            default:
                return ModelsList()
        }
    }

    internal static func listType(for legalPersonType : LegalPerson.LegalPersonType) -> AnyClass {
        assert(legalPersonType != .none, "The Type passed to this Function cannot be .none")
        switch legalPersonType {
            case .person:
                return Person.self
            case .organization:
                return Organization.self
            case .company:
                return Company.self
            default:
                return ModelsList.self

        }
    }

    internal static func list<T>() -> ModelsList<T> {
        switch T {
            default:
                return ModelsList()
        }
    }

    internal static func listType(for financeType : Finance.FinanceType) -> AnyClass {
        switch financeType {
            case .income:
                return Income.self
            case .expense:
                return Expense.self
        }
    }
}
