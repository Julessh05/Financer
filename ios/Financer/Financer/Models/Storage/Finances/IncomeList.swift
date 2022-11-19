//
//  IncomeList.swift
//  Financer
//
//  Created by Julian Schumacher on 18.11.22.
//

import Foundation

/// The List Model that contains all the stored incomes.
internal final class IncomeList : ModelsList<Income>, Instancable {
    static internal private(set) var instance: IncomeList = IncomeList()
}
