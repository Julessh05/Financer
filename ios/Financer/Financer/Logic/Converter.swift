//
//  Converter.swift
//  Financer
//
//  Created by Julian Schumacher on 20.11.22.
//

import Foundation


internal struct Converter {
    internal static func list(for legalPersonType : LegalPerson.LegalPersonType) -> any ModelsListProtocol {
        switch legalPersonType {
            case .person:
                return PersonList()
            case .organization:
                return OrganizationList()
            case .company:
                return CompanyList()
            default:
                return PersonList()
        }
    }
}
