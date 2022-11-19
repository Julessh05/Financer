//
//  PersonList.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation

/// The Model that contanins a List of all Persons
internal final class PersonList : ModelsList<Person>, Instancable {
    static internal private(set) var instance: PersonList = PersonList()
}
