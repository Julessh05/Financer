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

    /// The Relation if this Legal Person is
    /// a Person
    internal enum PersonRelation : String, Relation {

        var id : Self { self }

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

    /// The Relation if this Legal Person
    /// is a Company
    internal enum CompanyRelation : String, Relation {

        var id : Self { self }

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
    internal enum OrganizationRelation : String, Relation {

        var id : Self { self }
        /// The User is a member
        /// of this Organization
        case member
    }

    internal var id : UUID = UUID()

    /// The Name of this Legal Person
    internal let name : String

    /// The Relation of this Person and
    /// the User of this App
    private let personRelation : PersonRelation?

    /// The Relation of this Company and
    /// the User of this App
    private let companyRelation : CompanyRelation?

    /// The Relation of this Organization and
    /// the User of this App
    private let organizationRelation : OrganizationRelation?

    internal var relation: any Relation {
        get {
            if personRelation != nil {
                return personRelation!
            } else if companyRelation != nil {
                return companyRelation!
            } else {
                return organizationRelation!
            }
        }
    }

    /// The Phone Number of this Legal Person
    internal let phone : String

    /// The Notes to this Object
    internal let notes : String

    /// The Type of this Legal Person
    internal let type : LegalPersonType

    /// Initializer for a Person
    internal init(
        name : String,
        relation : PersonRelation,
        phone : String,
        notes : String
    ) {
        self.type = .person
        self.name = name
        self.personRelation = relation
        self.organizationRelation = nil
        self.companyRelation = nil
        self.phone = phone
        self.notes = notes
    }

    /// Initializer for a Company
    internal init(
        name : String,
        relation : CompanyRelation,
        phone : String,
        notes : String
    ) {
        self.type = .company
        self.companyRelation = relation
        self.personRelation = nil
        self.organizationRelation = nil
        self.name = name
        self.phone = phone
        self.notes = notes
    }

    /// Initializer for a Organization
    internal init(
        name : String,
        relation : OrganizationRelation,
        phone : String,
        notes : String
    ) {
        self.type = .organization
        self.name = name
        self.organizationRelation = relation
        self.personRelation = nil
        self.companyRelation = nil
        self.phone = phone
        self.notes = notes
    }

    required init(from decoder: Decoder) throws {
        let values : KeyedDecodingContainer = try decoder.container(keyedBy: Keys.self)
        name = try values.decode(String.self, forKey: .name)
        let type : String = try values.decode(String.self, forKey: .type)
        self.type = LegalPersonType(rawValue: type)!
        let relation : String
        if self.type == .person {
            relation = try values.decode(String.self, forKey: .personRelation)
            personRelation = PersonRelation(rawValue: relation)!
            companyRelation = nil
            organizationRelation = nil
        } else if self.type == .company {
            relation = try values.decode(String.self, forKey: .companyRelation)
            companyRelation = CompanyRelation(rawValue: relation)!
            personRelation = nil
            organizationRelation = nil
        } else {
            relation = try values.decode(String.self, forKey: .organizationRelation)
            organizationRelation = OrganizationRelation(rawValue: relation)!
            companyRelation = nil
            personRelation = nil
        }
        phone = try values.decode(String.self, forKey: .phone)
        notes = try values.decode(String.self, forKey: .notes)
        id = try values.decode(UUID.self, forKey: .id)
    }

    /// Keys to encode and decode Legal Persons
    internal enum Keys : CodingKey {
        /// The Name Attribute
        case name

        /// The Relation Attribute for a Person
        case personRelation

        /// The Relation Attribute for am Organization
        case organizationRelation

        /// The Relation Attribute for a Company
        case companyRelation

        /// The Phone Attribute
        case phone

        /// The Notes Attribute
        case notes

        /// The ID of this Object
        case id

        /// The Homepage for the Legal Person
        /// (only affective with Unions)
        case homepage

        /// The Type of this Legal Person
        case type
    }

    // Method to conform to Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type.rawValue, forKey: .type)
        if relation is PersonRelation {
            try container.encode(personRelation!.rawValue, forKey: .personRelation)
        } else if relation is CompanyRelation {
            try container.encode(companyRelation!.rawValue, forKey: .companyRelation)
        } else {
            try container.encode(organizationRelation!.rawValue, forKey: .organizationRelation)
        }
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
