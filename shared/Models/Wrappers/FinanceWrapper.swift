//
//  FinanceWrapper.swift
//  Financer
//
//  Created by Julian Schumacher on 01.01.23.
//

import Foundation

/// The Wrapper for a Finance Object that is
/// injected into the Environment via @StateObject. To ensure
/// that this is possible, this final class conforms to the Observable Object
/// class.
/// This class contains an optional Finance, that is the actual Object to use.
/// This Wrapper is just here to ensure that the Environment Object is never nil.
internal final class FinanceWrapper : ObservableObject {
    
    /// The Finance to actually use in this App
    @Published internal final var finance : Finance?
    
    /// Intializer to directly init this Object with a Finance.
    /// Mostly used for testing and previews
    internal init(finance: Finance? = nil) {
        self.finance = finance
    }
}
