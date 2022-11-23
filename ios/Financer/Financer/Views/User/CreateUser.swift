//
//  CreateUser.swift
//  Financer
//
//  Created by Julian Schumacher on 30.10.22.
//

import SwiftUI
import PhotosUI

/// View to create a User
internal struct CreateUser: View {

    /// The first Name of the User
    @State private var name : String = ""

    /// The last Name of the User
    @State private var lastname : String = ""

    /// The Date of Birth of the User
    @State private var date : Date = Date()

    /// Whether the Photo Library is shown or not.
    @State private var isLibraryShown : Bool = false

    /// The Image PIcked by the User
    @State private var pickedImage : UIImage?

    /// The Action to dismiss this View
    @Environment(\.dismiss) private var dismiss : DismissAction

    /// The User beeing created
    @Binding internal var user : User

    internal init(user: Binding<User>) {
        self._user = user
        _name = State(initialValue: user.wrappedValue.name)
        _lastname = State(initialValue: user.wrappedValue.lastname)
        _date = State(initialValue: user.wrappedValue.dateOfBirth)
        _pickedImage = State(initialValue: user.wrappedValue.picture)
    }

    var body: some View {
        GeometryReader { metrics in
            VStack {
                List {
                    HStack {
                        Spacer()
                        (pickedImage != nil ?
                         Image(uiImage: pickedImage!) :
                            Image(systemName: "person.crop.circle.fill.badge.plus"))
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFill()
                        .frame(
                            width: metrics.size.height / 8,
                            height: metrics.size.height / 9.5,
                            alignment: .center
                        )
                        .padding(.all, 25)
                        .clipShape(Circle())
                        .onTapGesture {
                            isLibraryShown.toggle()
                        }
                        .sheet(isPresented: $isLibraryShown) {
                            var conf : PHPickerConfiguration = PHPickerConfiguration(photoLibrary: .shared())
                            ImagePicker(conf: conf, pickedImage: $pickedImage, isPresented: $isLibraryShown).onAppear {
                                conf.filter = .images
                                conf.preferredAssetRepresentationMode = .automatic
                                conf.selectionLimit = 1
                            }
                        }
                        Spacer()
                    }

                    Section {
                        TextField("First Name", text: $name)
                        TextField("Last Name", text: $lastname)
                    } header: {
                        Text("Name")
                    } footer: {
                        Text("Edit your complete Name")
                    }

                    Section {
                        DatePicker("Date of Birth", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                    } header: {
                        Text("Date")
                    } footer: {
                        Text("Edit your Date of birth")
                    }
                }
                .textInputAutocapitalization(.words)

                Button {
                    user = User(name: name, lastname: lastname, date: date, picture: pickedImage)
                    Storage.storeImage(pickedImage)
                    SecureStorage.storeUser(user: user)
                    dismiss()
                } label: {
                    Spacer()
                    Label("Save", systemImage: "square.and.arrow.down")
                    .frame(width: metrics.size.width / 1.2,
                           height: metrics.size.height / 15)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    Spacer()
                }
                Button {

                } label: {

                }

            }
        }.navigationTitle("Edit User")
            .navigationBarTitleDisplayMode(.automatic)
            .textFieldStyle(.plain)
    }
}

struct CreateUser_Previews: PreviewProvider {
    /// The Uset used in this Preview
    @State static private var user : User = User()

    static var previews: some View {
        CreateUser(user: $user)
    }
}
