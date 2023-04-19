//
//  UserInformation.swift
//  Financer
//
//  Created by Julian Schumacher on 14.04.23.
//

import SwiftUI

/// This View informs the User about how the Account works,
/// what data are stored and where they are stored and some more information...
internal struct UserInformation: View {
    
    @Environment(\.dismiss) private var dismiss : DismissAction
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Data Storage")
                    .font(.headline)
                Text("The Data of your User account are stored locally")
                Text("If you enables iCloud Sync, it will be synced to your iCloud securely")
                Divider()
                Text("Data deletion")
                    .font(.headline)
                Text("If you log out of your user account, the data will automatically be deleted, because it's not really a user account, but rather a represent for a user")
            }
            .multilineTextAlignment(.leading)
            .navigationTitle("Information")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

internal struct UserInformation_Previews: PreviewProvider {
    static var previews: some View {
        UserInformation()
    }
}
