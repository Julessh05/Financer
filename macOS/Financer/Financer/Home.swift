//
//  ContentView.swift
//  Financer
//
//  Created by Julian Schumacher as ContentView.swift on 29.10.22.
//
//  Renamed by Julian Schumacher to Home.swift on 08.01.23
//

import SwiftUI

internal struct Home: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
