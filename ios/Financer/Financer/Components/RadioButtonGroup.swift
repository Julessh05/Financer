//
//  RadioButtonGroup.swift
//  Financer
//
//  Created by Julian Schumacher on 16.11.22.
//

import SwiftUI

/// A Group of Radio Buttons
internal struct RadioButtonGroup: View {

    /// The Axis in which this should be aligned
    internal let axis : Axis

    /// The Items of this View
    internal let items : [RadioButtonData]

    var body: some View {
        if axis == .horizontal {
            HStack {
                list()
            }
        } else {
            VStack {
                list()
            }
        }
    }

    @ViewBuilder
    private func list() -> some View {
        Spacer()
        ForEach(items) { item in
            if axis == .horizontal {
                RadioButtonHorizontal(
                    name: item.name,
                    image: item.image
                )
            } else {
                RadioButtonVertical(
                    name: item.name,
                    image: item.image
                )
            }
            Spacer()
        }
    }
}

struct RadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup(
            axis: .horizontal,
            items: [
                RadioButtonData(name: "Person", image: Image(systemName: "person")),
                RadioButtonData(name: "Company", image: Image(systemName: "globe"))
            ]
        )
    }
}
