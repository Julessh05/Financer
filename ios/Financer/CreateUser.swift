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

    var body: some View {
        GeometryReader { metrics in
            VStack {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
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
                        var conf : PHPickerConfiguration = PHPickerConfiguration(photoLibrary: .shared());
                        ImagePicker(conf: conf, pickedImage: $pickedImage, isPresented: $isLibraryShown).onAppear {
                            conf.filter = .images
                            conf.preferredAssetRepresentationMode = .automatic
                            conf.selectionLimit = 1
                        }
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

                Spacer()

                Button {
                    // TODO: change
                    _ = environment(\.currentUser, User(name: name, lastname: lastname, date: date, picture: pickedImage))
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add User").font(.headline)
                    }
                    .frame(width: metrics.size.width / 1.2,
                           height: metrics.size.height / 15)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                }

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
