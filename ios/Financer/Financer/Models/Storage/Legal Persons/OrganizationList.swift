//
//  OrganizationsLis.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation

/// The List Model that contains al the Organizations
internal final class OrganizationList : ModelsList<Organization>, Instancable {
    static internal private(set) var instance: OrganizationList = OrganizationList()
}
