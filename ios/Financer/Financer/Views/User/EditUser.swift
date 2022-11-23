//
//  EditUser.swift
//  Financer
//
//  Created by Julian Schumacher on 23.11.22.
//

import SwiftUI

/// Struct to edit the current User
internal struct EditUser: View {
    /// The User to edit
    @Binding internal var user : User

    var body: some View {
        VStack {
            
        }
    }
}

struct EditUser_Previews: PreviewProvider {
    /// The user used in this Preview
    @State static private var localUser : User = User()
    static var previews: some View {
        EditUser(user: $localUser)
    }
}
