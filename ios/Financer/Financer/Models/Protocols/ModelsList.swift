//
//  ModelsList.swift
//  Financer
//
//  Created by Julian Schumacher as ModelsListProtocol on 18.11.22.
//  Renamed by Julian Schumacher to ModelsList on 21.11.22.
//

import Foundation

/// Protocol used to implement
/// the Model that all Lists of Models must
/// conform to.
internal protocol ModelsList : Instancable {
    
    /// The associated Type inside this Model
    /// to create abstract Functions
    associatedtype ModelsListType
    
    /// The List of the actual items
    var items : [ModelsListType] { get }
    
    /// Adds the specified Item to the List of
    /// all Items
    mutating func add(item : ModelsListType) -> Void

    /// Adds all the specied items to the list
    mutating func add(items localItems: [ModelsListType]) -> Void

    /// Replaces the specified Item in this List.
    /// This is used to edit Items
    mutating func replace(toReplace : ModelsListType, replace : ModelsListType) -> Void
    
    /// Removes and Deletes the specified Item in this List
    mutating func delete(item : ModelsListType) -> Void

    /// Deletes all the specified Items from the List
    mutating func delete(items localItems: [ModelsListType]) -> Void
}
