//
//  LegalPersonListTile.swift
//  Financer
//
//  Created by Julian Schumacher as LegalPersonListTile.swift on 24.12.22.
//
// Renamed by Julian Schumacher to ListTile.swift on 24.12.22

import SwiftUI


/// The List TIle to represent Model  in a List
internal struct ListTile: View {
    /// The Legal Person for this View
    @State private var person : LegalPerson
    /// The Finance for this View
    @State private var finance : Finance
    /// The Type passed to this View
    @State private var typePassed : TypePassed
    /// Enum to define which type was passed to
    /// this View, so this View can represens and behave accordingly
    private enum TypePassed {
        /// A Legal Person is passed
        case person
        /// A Finance is passed
        case finance
    }
    /// The callback to execute
    private let callback : () -> ()
    internal init(person: LegalPerson, _ callback : @escaping () -> ()) {
        self._person = State(initialValue: person)
        self.callback = callback
        self.finance = Finance.anonymous
        self.typePassed = .person
    }
    internal init(finance : Finance, _ callback : @escaping () -> ()) {
        self._finance = State(initialValue: finance)
        self.callback = callback
        self.person = LegalPerson.anonymous
        self.typePassed = .finance
    }
    /// Whether the Info View is active or not.
    @State private var viewActive : Bool = false
    var body: some View {
        HStack {
            HStack {
                // TODO: change finance attribute
                Text(typePassed == .person ? person.name : String(finance.amount))
                Spacer()
            }
            // Solution from: https://stackoverflow.com/questions/57191013/swiftui-cant-tap-in-spacer-of-hstack
            .contentShape(Rectangle())
            .onTapGesture { callback() }
            Button {
                viewActive.toggle()
            } label: {
                Image(systemName: "info.circle")
            }.sheet(isPresented: $viewActive) {
                if typePassed == .person {
                    LegalPersonDetails(person: $person)
                } else {
                    FinanceDetails(finance : $finance)
                }
            }
        }
    }
}
internal struct LegalPersonListTile_Previews: PreviewProvider {
    static var previews: some View {
        ListTile(
            person: LegalPerson.anonymous,
            { print("Callback activated") }
        )
    }
}
