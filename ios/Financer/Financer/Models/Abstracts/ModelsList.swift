//
//  ModelsList.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation

/// Protocol used to implement
/// the Model that all Lists of Models must
/// conform to.
internal protocol ModelsListProtocol {

    /// The associated Type inside this Model
    /// to create abstract Functions
    associatedtype ModelsListType

    /// The List of the actual items
    static var items : [ModelsListType] { get }

    /// Adds the specified Item to the List of
    /// all Items
    static func addItem(item : ModelsListType) -> Void

    /// Removes and Deletes the specified Item in this List
    static func deleteItem(item : ModelsListType) -> Void

    static func list(for legalPersonType : LegalPerson.LegalPersonType) -> ModelsList<T: Equatable>

    static func list(for financeType : Finance.FinanceType) -> ModelsList<T: Equatable>
}


/// Model for all the Lists that are used to store properties.
internal class ModelsList<T> : ModelsListProtocol where T : Equatable {


    internal typealias ModelsListType = T

    internal static var items: [T] = []

    internal static func addItem(item: T) -> Void {
        items.append(item)
    }

    internal static func deleteItem(item: T) -> Void {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }

    internal static func list(for legalPersonType : LegalPerson.LegalPersonType) -> ModelsList {
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

    internal static func list(for financeType : Finance.FinanceType) -> Void {

    }
}
