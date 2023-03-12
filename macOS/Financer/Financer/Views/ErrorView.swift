//
//  ErrorView.swift
//  Financer
//
//  Created by Julian Schumacher on 12.03.23.
//

import SwiftUI

/// An Error View to show an Error, if something unexcepted in the
/// App happens
internal struct ErrorView: View {
    
    internal var error : Error? = nil
    
    var body: some View {
        VStack {
            Text("There was an Error:")
            if let e = error {
                Text(e.localizedDescription)
            } else {
                Text("Something unexpected happened.")
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
