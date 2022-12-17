//
//  DetailLabel.swift
//  Financer
//
//  Created by Julian Schumacher on 19.11.22.
//

import SwiftUI

/// A Label that contains
/// a Title and the current Data.
///
/// Can for example be used in a
/// Navigation Link
struct DetailLabel: View {

    /// The Title of the Label.
    /// This is displayed first
    /// thing in the stack
    let title : String

    /// The Data of this Label.
    /// This is displayed at the end
    /// of the stack
    let data : String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(data)
        }
    }
}

struct DetailLabel_Previews: PreviewProvider {
    static var previews: some View {
        DetailLabel(title: "Title", data: "Data")
    }
}
