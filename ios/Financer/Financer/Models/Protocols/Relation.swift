//
//  Relation.swift
//  Financer
//
//  Created by Julian Schumacher on 26.11.22.
//

import Foundation

/// The Protocol all the
/// different Types of Relations have
/// to correspond to
internal protocol Relation : CaseIterable,
                             Identifiable,
                             Equatable,
                             Codable,
                             RawRepresentable where RawValue == String {}

extension Relation {
    init(from decoder: Decoder) throws {
        let values : KeyedDecodingContainer = try decoder.container(keyedBy: )
    }

    func encode(to encoder: Encoder) throws {

    }
}
