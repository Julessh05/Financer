//
//  DeleteButton.swift
//  Financer
//
//  Created by Julian Schumacher on 29.01.23.
//

import CoreData
import SwiftUI

/// A Button to Delete Data.
/// The action should be a function to
/// delete the actual Data.
///
/// This View is mpstly installed in a Swipe Action
/// Context
internal struct DeleteButton: View {
    
    internal let action : () -> Void
    
    var body: some View {
        Button(action: { action() }) {
            Image(systemName: "trash")
                .renderingMode(.original)
        }
        .tint(.red)
    }
}

internal struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton {
            print("Action executed")
        }
    }
}
