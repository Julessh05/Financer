//
//  CreateUser.swift
//  Financer
//
//  Created by Julian Schumacher on 30.10.22.
//

import SwiftUI

/// View to create a User
internal struct CreateUser: View {

    /// The first Name of the User
    @State private var name : String = ""

    /// The last Name of the User
    @State private var lastname : String = ""

    /// The Date of Birth of the User
    @State private var date : Date = Date()

    var body: some View {
        GeometryReader { metrics in
            VStack {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .renderingMode(.original)
                    .frame(
                        width: metrics.size.height / 8,
                        height: metrics.size.height / 9.5,
                        alignment: .center
                    )
                    .padding(.all, 25)
                    .clipShape(Circle())
                    .onTapGesture {
                        // TODO: Add Action Code
                    }

                HStack {
                    TextField("Name", text: $name)
                        .textContentType(.givenName)
                    TextField("Last Name", text: $lastname)
                        .textContentType(.familyName)
                }
                .textInputAutocapitalization(.words)

                DatePicker("Date of Birth", selection: $date,displayedComponents: [.date])
                    .datePickerStyle(.automatic)

            }.navigationTitle("Create User")
                .navigationBarTitleDisplayMode(.automatic)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
        }
    }
}

struct CreateUser_Previews: PreviewProvider {
    static var previews: some View {
        CreateUser()
    }
}
