//
//  Converter.swift
//  Financer
//
//  Created by Julian Schumacher on 20.11.22.
//

import Foundation

/// A Converter struct for this App
/// to convert stuff from a to b.
///
/// Just a Container, all of
/// the Functions are static
internal struct Converter {

    /// Returns the filtered List of Legal Persons for the specified Enum Type
    /// passed to this Function
    internal static func list(for legalPersonType : LegalPerson.LegalPersonType) -> [LegalPerson]  {
        switch legalPersonType {
            case .person:
                return LegalPersonList.instance.items.filter({ $0 is Person })
            case .organization:
                return LegalPersonList.instance.items.filter({ $0 is Organization })
            case .company:
                return LegalPersonList.instance.items.filter({ $0 is Company })
            default:
                return LegalPersonList.instance.items
        }
    }

    /// Returns the filtered List of Finances for the specified Enum Type
    /// passed to this Function
    internal static func list(for financeType : Finance.FinanceType) -> [Finance] {
        switch financeType {
            case .income:
                return FinanceList.instance.items.filter({ $0 is Income })
            case .expense:
                return FinanceList.instance.items.filter({ $0 is Expense })
        }
    }

    /// Returns the Enum case of LegalPersonType depending on the Legal Person beeing passed in.
    internal static func legalPersonType(for legalPerson : LegalPerson) -> LegalPerson.LegalPersonType {
        switch legalPerson.self {
            case is Union:
                return legalPerson.self is Company ? .company : .organization
            case is Person:
                return .person
            default:
                return .none
        }
    }
}
