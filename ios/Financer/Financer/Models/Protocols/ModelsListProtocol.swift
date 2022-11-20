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
    associatedtype ModelsListType : Equatable, Identifiable
    
    /// The List of the actual items
    var items : [ModelsListType] { get }
    
    /// Adds the specified Item to the List of
    /// all Items
    func add(item : ModelsListType) -> Void

    /// Adds all the specied items to the list
    func add(items: [ModelsListType]) -> Void
    
    /// Removes and Deletes the specified Item in this List
    func delete(item : ModelsListType) -> Void

    /// Deletes all the specified Items from the List
    func delete(items: [ModelsListType]) -> Void
}
