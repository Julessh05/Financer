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

    internal func addItem(item: T) -> Void {
        items.append(item)
    }

    internal func deleteItem(item: T) -> Void {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }

    internal static func list(for legalPersonType : LegalPerson.LegalPersonType) -> Any {
        assert(legalPersonType != .none, "The Type passed to this Function cannot be .none")
        switch legalPersonType {
            case .person:
                return PersonList()
            case .organization:
                return OrganizationList()
            case .company:
                return CompanyList()
            default:
                return ModelsList()
        }
    }

    internal static func list(for financeType : Finance.FinanceType) -> Any {
        // TODO: change
        return self
    }
}
