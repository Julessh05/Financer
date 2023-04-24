//
//  UserEditor.swift
//  Financer
//
//  Created by Julian Schumacher on 07.01.23.
//

import SwiftUI
import PhotosUI

/// The View to edit a Users Data
internal struct UserEditor: View {
    
    /// The Action to dismiss this View
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    /// The Context to interact with the
    /// Core Data Manager
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The Image the User picked for his
    /// User Account
    @State private var image : UIImage? = nil
    
    /// The Firstname of the User
    @State private var firstname : String = ""
    
    /// The Lastname of the User
    @State private var lastname : String = ""
    
    /// The Date of Birth of this User
    @State private var dateOfBirth : Date = Date()
    
    /// Whether to use a date of birth or not
    @State private var useDateOfBirth : Bool = false
    
    /// The Gender of the User
    @State private var gender : User.Gender = .none
    
    /// Whether the Button is active (all Data are entered) or not.
    @State private var btnActive : Bool = false
    
    /// Whether ther Error for missing Arguments is displayed or not.
    @State private var errMissingArgumentsPresented : Bool = false
    
    /// Whether the User's Library is shown or not.
    @State private var isLibraryShown : Bool = false
    
    @FocusState private var firstnameFocused : Bool
    
    @FocusState private var lastnameFocused : Bool
    
    /// The callback being executed when the Save or Done Button
    /// is tapped.
    private let callback : (User) -> Void
    
    /// The Initializer to add or edit
    /// a User.
    /// If you pass a User, it will be edited,
    /// otherwise a new User will be created
    internal init(
        action : @escaping (User) -> Void,
        user : User? = nil
    ) {
        self.callback = action
        if user != nil {
            _firstname = State(initialValue: user!.firstname!)
            _lastname = State(initialValue: user!.lastname!)
            if user!.dateOfBirth != nil {
                _useDateOfBirth = State(initialValue: true)
                _dateOfBirth = State(initialValue: user!.dateOfBirth!)
            }
            if user!.gender != User.Gender.none.rawValue {
                _gender = State(initialValue: User.Gender(rawValue: user!.gender!)!)
            }
            if user!.image != nil {
                _image = State(initialValue: UIImage(data: user!.image!))
            }
        }
        firstnameFocused = true
    }
    
    var body: some View {
        GeometryReader {
            metrics in
            VStack {
                Form {
                    HStack {
                        Spacer()
                        imageSection()
                            .frame(
                                width: metrics.size.width / 2.25,
                                height: metrics.size.height / 5,
                                alignment: .center
                            )
                        Spacer()
                    }
                    Section {
                        TextField("Firstname", text: $firstname)
                            .focused($firstnameFocused, equals: true)
                            .textContentType(.givenName)
                            .onChange(of: firstname) {
                                _ in
                                checkBtn()
                            }
                            .onSubmit {
                                firstnameFocused.toggle()
                                lastnameFocused.toggle()
                            }
                        TextField("Lastname", text: $lastname)
                            .focused($lastnameFocused, equals: true)
                            .textContentType(.familyName)
                            .onChange(of: lastname) {
                                _ in
                                checkBtn()
                            }
                    } header: {
                        Text("Required")
                    } footer: {
                        Text("These Data are required to log in")
                    }
                    .textInputAutocapitalization(.words)
                    .keyboardType(.asciiCapable)
                    Section {
                        datePicker()
                        Picker("Gender", selection: $gender) {
                            ForEach(User.Gender.allCases) {
                                gender in
                                Text(gender.rawValue.capitalized)
                            }
                        }
                        
                        .pickerStyle(.menu)
                    } header: {
                        Text("Optional")
                    } footer: {
                        Text("You don't have to enter these Data, they're optional")
                    }
                }
                Button(action: action) {
                    Label(
                        "Save",
                        systemImage: "square.and.arrow.down"
                    )
                    .frame(
                        width: metrics.size.width / 1.2,
                        height: metrics.size.height / 15
                    )
                    .foregroundColor(.white)
                    .background(btnActive ? Color.blue : Color.gray)
                    .cornerRadius(20)
                }
                .alert(
                    "Missing Data",
                    isPresented: $errMissingArgumentsPresented
                ) {
                } message: {
                    Text("Please enter all required Data before you continue")
                }
            }
        }
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden()
        .textFieldStyle(.plain)
        .formStyle(.grouped)
        .onAppear { checkBtn() }
        .toolbarRole(.navigationStack)
        .toolbar(.automatic, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    action()
                }
            }
        }
    }
    
    /// Renders, builds and returns the Section
    /// for the User Image, depending on whether
    /// the User has passed an image or not
    @ViewBuilder
    private func imageSection() -> some View {
        Button {
            isLibraryShown.toggle()
        } label: {
            if image != nil {
                Image(uiImage: image!)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.badge.plus")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
            }
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $isLibraryShown) {
            var conf : PHPickerConfiguration = PHPickerConfiguration(photoLibrary: .shared())
            ImagePicker(conf: conf, pickedImage: $image, isPresented: $isLibraryShown).onAppear {
                conf.filter = .images
                conf.preferredAssetRepresentationMode = .automatic
                conf.selectionLimit = 1
            }
        }
    }
    
    /// Builds, renders and returns the Date Picker
    /// for the Users Date of Birth
    @ViewBuilder
    private func datePicker() -> some View {
        Toggle("Use Date of Birth", isOn: $useDateOfBirth.animation())
        if useDateOfBirth {
            DatePicker(
                "Date",
                selection: $dateOfBirth,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }
    }
    
    /// Checks if all required Data are entered, and if so
    /// activates the Button.
    private func checkBtn() -> Void {
        btnActive = !firstname.isEmpty && !lastname.isEmpty
    }
    
    /// The action to create a Legal Person and pass
    /// it to the callback
    private func action() -> Void {
        if btnActive {
            let user = User(context: viewContext)
            user.firstname = firstname
            user.lastname = lastname
            user.gender = gender.rawValue
            user.image = image?.jpegData(compressionQuality: 0.5)
            if useDateOfBirth {
                user.dateOfBirth = dateOfBirth
            }
            user.userCreated = true
            callback(user)
            dismiss()
        } else {
            errMissingArgumentsPresented.toggle()
        }
    }
}

internal struct UserEditor_Previews: PreviewProvider {
    static var previews: some View {
        UserEditor(action: {
            _ in
            print("Preview Button Pressed")
        })
    }
}
