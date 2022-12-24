//
//  LegalPersonPicker.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//

import SwiftUI

/// The View to pick a legal Person
/// for a single Finance
internal struct LegalPersonPicker: View {
    
    /// The Legal Person beeing chosen
    @Binding internal var legalPerson : LegalPerson?
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle("Legal Person Picker")
    }
}

internal struct LegalPersonPicker_Previews: PreviewProvider {
    /// The Preview Legal Person
    @State static private var lP : LegalPerson? = {
        let context = PersistenceController.preview.container.viewContext
        let person = Person(context: context)
        person.name = "Test Person"
        return person
    }()
    
    static var previews: some View {
        LegalPersonPicker(legalPerson: $lP)
    }
}
