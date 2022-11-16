//
//  LegalPersonChooser.swift
//  Financer
//
//  Created by Julian Schumacher on 16.11.22.
//

import SwiftUI

/// View to choose which legal Person should be created
struct LegalPersonChooser: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "person")
                Text("Person")
                
            }
            Spacer()
            VStack {
                Image(systemName: "globe")
                Text("Company")
            }
            Spacer()
            VStack {
                Image(systemName: "person.fill")
                Text("")
            }
            Spacer()
        }
    }
}

struct LegalPersonChooser_Previews: PreviewProvider {
    static var previews: some View {
        LegalPersonChooser()
    }
}
