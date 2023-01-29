//
//  FinanceSort.swift
//  Financer
//
//  Created by Julian Schumacher on 26.01.23.
//

import Foundation

// Explanation for where: https://stackoverflow.com/questions/30746190/swift-where-array-extensions
// Answer here: https://stackoverflow.com/a/30746254/16376071

/// Extension on an Random Access Collection of Finances.
///
/// This Extension manages the Sort and Getter Functions
/// for this Type
extension RandomAccessCollection where Element : Finance {
    
    /// Returns the Latest Edited Object in the Array.
    /// If the Array is empty, returns nil.
    internal func latest() -> Finance? {
        guard !self.isEmpty else {
            return nil
        }
        var latest : Finance? = nil
        for finance in self {
            guard latest != nil else {
                latest = finance
                continue
            }
            // Date Comparison from: https://stackoverflow.com/questions/52337853/date-from-calendar-datecomponents-returning-nil-in-swift
            // Answer here: https://stackoverflow.com/a/52338229/16376071
            if finance.date! > latest!.date! {
                latest = finance
            }
        }
        return latest!
    }
}
