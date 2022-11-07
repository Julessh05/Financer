//
//  UserDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 06.11.22.
//

import SwiftUI

struct UserDetails: View {
    @Environment(\.currentUser) private var user

    var body: some View {
        List {
            Text(user.name)
            Text(user.lastname)
        }.navigationTitle("User Details")
    }
}

struct UserDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserDetails()
    }
}
