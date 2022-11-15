//
//  LegalPerson.swift
//  Financer
//
//  Created by Julian Schumacher on 14.11.22.
//

import Foundation

/// The Protocol all the
/// different Types of Relations have
/// to correspond to
internal protocol Relation : CaseIterable, Identifiable {}

/// The class all Legal Persons extend from
internal class LegalPerson {

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

    /// The Relation if this LEgal Person is an Organization
    internal enum OrganizationRelation : String, Relation {
        var id : Self { self }

        /// The User is a member
        /// of this Organization
        case member
    }

    /// The Name of this Legal Person
    internal let name : String

    /// The Relation of this Legal Person and
    /// the User of this App
    internal let relation : any Relation

    /// Initializer with all Values
    internal init(name : String, relation : any Relation) {
        self.name = name
        self.relation = relation
    }
}
