//
//  LegalPerson.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// The class all Legal Persons extend from
internal class LegalPerson : Equatable, Identifiable, Codable {
    /// The Type of this Legal Person
    internal enum LegalPersonType : String, CaseIterable, Identifiable {
        var id : Self { self }

        /// no Value given
        case none

        /// This Legal Person is
        /// a Company
        case company

        /// This Legal Person is
        /// an Organization
        case organization

        /// This Legal Person is a person
        case person
    }

    internal enum Relation : String {
        /// The Relation if this Legal Person
        /// is a Company
        internal enum Company {
            /// The User is an Employee of this Company
            case employee

            /// The User is an external working Person
            /// that is arranged in this Company
            case externalWorker

            /// A Customer of this Company
            case customer

            /// A single Supplier of this Company.
            case supplier

            /// The CEO of this Company
            case ceo

            /// The User is a Share Holder of this Company.
            /// The Incomes and Expenses are dividents.
            case shareholder
        }

        /// The Relation if this Legal Person is an Organization
        internal enum Organization {
            /// The User is a member
            /// of this Organization
            case member
        }

        /// The Relation if this Legal Person is
        /// a Person
        internal enum Person {
            /// The Legal Person that can accept Finances is
            /// a Person of the Users Family
            case family

            /// The Legal Person is a friend of
            /// the User
            case friend

            /// The Person is a public figure
            /// as a  Youtuber, Streamer or Influencer
            case publicFigure
        }
    }

    internal var id : UUID = UUID()

    /// The Name of this Legal Person
    internal let name : String

    /// The Relation of this Legal Person and
    /// the User of this App
    internal let relation : Relation

    /// The Phone Number of this Legal Person
    internal let phone : String

    /// The Notes to this Object
    internal let notes : String

    /// Initializer with all Values
    internal init(
        name : String,
        relation : any Relation,
        phone : String,
        notes : String
    ) {
        self.relation = .Person.family
        self.name = name
        self.relation = relation
        self.phone = phone
        self.notes = notes
    }

    required init(from decoder: Decoder) throws {
        let values : KeyedDecodingContainer = try decoder.container(keyedBy: Keys.self)
        name = try values.decode(String.self, forKey: .name)
        relation = try values.decode((any Relation).self, forKey: .relation)
        phone = try values.decode(String.self, forKey: .phone)
        notes = try values.decode(String.self, forKey: .notes)
        id = try values.decode(UUID.self, forKey: .id)
    }

    /// Keys to encode and decode Legal Persons
    internal enum Keys : CodingKey {
        /// The Name Attribute
        case name

        /// The Relation Attribute
        case relation

        /// The Phone Attribute
        case phone

        /// The Notes Attribute
        case notes

        /// The ID of this Object
        case id

        /// The Homepage for the Legal Person
        /// (only affective with Unions)
        case homepage
    }

    // Method to conform to Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
        try container.encode(relation, forKey: .relation)
        try container.encode(phone, forKey: .phone)
        try container.encode(notes, forKey: .notes)
        try container.encode(id, forKey: .id)
    }

    // Override to conform to Equatable
    static func == (lhs: LegalPerson, rhs: LegalPerson) -> Bool {
        return lhs.name == rhs.name && lhs.notes == rhs.notes && lhs.phone == rhs.phone
        // TODO: check this: && lhs.relation == rhs.relation
    }
}
