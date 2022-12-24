//
//  LegalPersonDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//

import SwiftUI

/// This View represents a Legal Person and shows all
/// it's details.
internal struct LegalPersonDetails: View {
    
    @State internal var legalPerson : LegalPerson
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

internal struct LegalPersonDetails_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonDetails(legalPerson: LegalPerson.anonymous)
    }
}
