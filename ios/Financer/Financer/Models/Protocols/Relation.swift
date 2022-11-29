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

/// The Enum to encode and decode this Protocols Value
private enum Keys : CodingKey {
    case relation
}

/// The Extension on this Protocol, to make it conform to
/// Codable
extension Relation {
    init(from decoder: Decoder) throws {
        let values : KeyedDecodingContainer = try decoder.container(keyedBy: Keys.self)
        self = try values.decode(Self.self, forKey: .relation)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(rawValue, forKey: .relation)
    }
}
