//
//  DefaultListTile.swift
//  Financer
//
//  Created by Julian Schumacher on 29.12.22.
//

import SwiftUI

internal struct DefaultListTile: View {
    
    /// The Name of this List Tile's Data
    internal let name : String
    
    /// The actual Data of this List Tile
    internal let data : String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(data)
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
    }
}

internal struct DefaultListTile_Previews: PreviewProvider {
    static var previews: some View {
        DefaultListTile(
            name: "Test",
            data: "Value"
        )
    }
}
