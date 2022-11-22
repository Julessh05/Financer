//
//  UserDetails.swift
//  Financer
//
//  Created by Julian Schumacher on 06.11.22.
//

import SwiftUI

/// View to display the User Data
struct UserDetails: View {
    
    /// The current User of this App
    @Binding internal var user : User

    /// Whether the Confirmation Dialog is presented or not
    @State private var dialogPresented : Bool = false

    var body: some View {
        GeometryReader { metrics in
            VStack {
                buildBody()

                Button(role: .destructive) {
                    dialogPresented.toggle()
                } label: {
                    HStack {
                        Image(systemName: "trash.fill")
                            .renderingMode(.original)
                        Text("Delete Data")
                            .font(.headline)
                    }
                    .confirmationDialog("Are your sure?", isPresented: $dialogPresented, titleVisibility: .visible) {
                        Button("Yes", role: .destructive) {
                            Storage.eraseAllData()
                        }
                    }
                    .foregroundColor(.red)
                    .frame(width: metrics.size.width / 1.2, height: metrics.size.height / 15, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(20)
                }
                // TODO: why is it like it is?
                .padding(.horizontal, metrics.size.width / 12)
            }
        }
        .navigationTitle("User Details")
    }

    /// Builds the Body depending on
    /// the State of the User.
    /// Returns a Button to create a new User, if none exists,
    /// and displays Data of the User,
    /// if one exists.
    @ViewBuilder
    private func buildBody() -> some View {
        if user.isAnonymous {
            Spacer()
            HStack {
                Image(systemName: "person.fill.xmark")
                Text("No User is logged in")
            }
            Spacer()
            NavigationLink(destination: CreateUser(user: $user)) {
                HStack {
                    Image("person.crop.circle.fill.badge.plus")
                    Text("Add User")
                }.font(.headline)
                    .foregroundColor(.blue)
            }
        } else {
            List {
                listTile(title: "Name", value: user.name)
                listTile(title: "Lastname", value: user.lastname)
                listTile(title: "Date of Birth", value: user.dateOfBirth.formatted(date: .abbreviated, time: .omitted))
            }
        }
    }

    /// Returns a List Tile, that can be used
    /// to display Information about the User
    @ViewBuilder
    private func listTile(title : String, value : String) -> HStack<TupleView<(Text, Spacer, Text)>> {
        HStack(alignment: .center) {
            Text(title)
            Spacer()
            Text(value)
        }
    }
}

struct UserDetails_Previews: PreviewProvider {
    /// The User used in this Preview
    @State static private var localPreviewUser : User = User()

    static var previews: some View {
        UserDetails(user: $localPreviewUser)
    }
}
