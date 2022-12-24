//
//  LegalPersonListTile.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//

import SwiftUI

/// A Component used to display a Legal Person to
/// the User.
internal struct LegalPersonListTile: View {
    
    /// The Legal Person beeing represented.
    internal let legalPerson : LegalPerson
    
    var body: some View {
        HStack {
            Text(legalPerson.name ?? "Unknown Person")
            Spacer()
        }
    }
}

struct LegalPersonListTile_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonListTile(legalPerson: LegalPerson.anonymous)
    }
}
