//
//  ListTile.swift
//  Financer
//
//  Created by Julian Schumacher on 26.11.22.
//

import SwiftUI

/// A General List Tile to represent some Data
/// in a List Row
internal struct ListTile: View {

    /// The Title of this List Tile.
    /// This is displayed on the left Side of
    /// the Tile.
    internal let title : String

    /// The Data of this Tile.
    /// This is represented on the
    /// right side of this View
    internal let data : String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(data)
        }
    }
}

struct ListTile_Previews: PreviewProvider {
    static var previews: some View {
        ListTile(title: "Test", data: "Another Test")
    }
}
