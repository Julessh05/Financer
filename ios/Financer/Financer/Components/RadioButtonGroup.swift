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
    internal let items : [RadioButton]

    var body: some View {
        if axis == .horizontal {
            HStack {
                forEach()
            }
        } else {
            VStack {
                forEach()
            }
        }
    }

    @ViewBuilder
    private func forEach() -> some View {
        ForEach(items) { item in
            item.image
            Text(item.name)
            circleBtn(item: item)
        }
    }

    @ViewBuilder
    private func circleBtn(item : Binding<RadioButton>) -> some View {
        Button {

        } label: {
            item.wrappedValue.selected ?
            Image(systemName: "circle.fill") :
            Image(systemName: "circle")
        }
    }
}

struct RadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup(axis: .vertical, items: [RadioButton(name: "Person", image: Image(systemName: "person"))])
    }
}
