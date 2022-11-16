//
//  RadioButtons.swift
//  Financer
//
//  Created by Julian Schumacher as RadioButton on 16.11.22.
//  Renamed by Julian Schmumacher to RadioButtons on 16.11.22.
//

import Foundation
import SwiftUI

/// A single Radio Button Representation on the Horizontal Axis
internal struct RadioButtonHorizontal : View, Identifiable {
    internal var id: UUID

    /// The Name of this Button
    internal let name : String

    /// the Image of this Button
    internal let image : Image

    /// Whether this Item
    /// is selected or not
    @State internal var selected : Bool = false

    init(name: String, image: Image) {
        id = UUID()
        self.name = name
        self.image = image
    }

    var body: some View {
        VStack {
            image
                .renderingMode(.original)
                .scaleEffect(4)
            Spacer()
                .frame(height: 40)
            Text(name).font(.title3)
            Spacer()
                .frame(height: 10)
            Button {
                selected.toggle()
            } label: {
                selected ?
                Image(systemName: "circle.fill")
                    .renderingMode(.original)
                    .scaleEffect(1.5) :
                Image(systemName: "circle")
                    .renderingMode(.original)
                    .scaleEffect(1.5)
            }.foregroundColor(.primary)
        }
    }
}


/// A single Radio Button Representation on the Vertical Axis
internal struct RadioButtonVertical : View, Identifiable {
    internal var id: UUID

    /// The Name of this Button
    internal let name : String

    /// the Image of this Button
    internal let image : Image

    /// Whether this Item
    /// is selected or not
    @State internal var selected : Bool = false

    init(name: String, image: Image) {
        id = UUID()
        self.name = name
        self.image = image
    }

    var body: some View {
        HStack {
            Button {
                selected.toggle()
            } label: {
                selected ?
                Image(systemName: "circle.fill")
                    .renderingMode(.original)
                    .scaleEffect(1.5) :
                Image(systemName: "circle")
                    .renderingMode(.original)
                    .scaleEffect(1.5)
            }.foregroundColor(.primary)
            Spacer().frame(width: 20)
            image
                .renderingMode(.original)
                .scaleEffect(1.3)
            Spacer().frame(width: 10)
            Text(name).font(.title3)

        }
    }
}

internal struct RadioButtonHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonHorizontal(name: "Person", image: Image(systemName: "person"))
    }
}

internal struct RadioButtonVertical_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonVertical(name: "Person", image: Image(systemName: "person"))
    }
}
