//
//  ModelsListProtocol.swift
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
    var items : [ModelsListType] { get }
    
    /// Adds the specified Item to the List of
    /// all Items
    func addItem(item : ModelsListType) -> Void
    
    /// Removes and Deletes the specified Item in this List
    func deleteItem(item : ModelsListType) -> Void
    
    /// returns the List for the specified Legal Person Type
    static func list(for legalPersonType : LegalPerson.LegalPersonType) -> Any
    
    /// returns the List for the specified Finance Type
    static func list(for financeType : Finance.FinanceType) -> Any
}
