//
//  DefaultListTile.swift
//  Financer
//
//  Created by Julian Schumacher as DefaultListTile.swift on 29.12.22.
//
//  Renamed by Julian Schumacher to ListTile.swift on 08.01.23
//

import SwiftUI

/// A Default List Tile displaying Name and Data
/// of the Data being displayed
internal struct ListTile: View {
    
    /// The Name of this List Tile's Data
    internal let name : String
    
    /// The actual Data of this List Tile
    internal let data : String
    
    /// The Action that is called when the User taps on the
    /// List Tile
    internal var onTap : () -> () = {}
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(data)
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

internal struct DefaultListTile_Previews: PreviewProvider {
    static var previews: some View {
        ListTile(
            name: "Test",
            data: "Value",
            onTap: {
                print("On Tap pressed")
            }
        )
    }
}
