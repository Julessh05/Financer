//
//  CompanyList.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation

/// The List Model that contains all the Companies
internal final class CompanyList : ModelsList<Company>, Instancable {
    static internal private(set) var instance: CompanyList = CompanyList()
}
