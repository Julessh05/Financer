//
//  AddLegalPerson.swift
//  Financer
//
//  Created by Julian Schumacher on 24.12.22.
//

import SwiftUI

/// View to Create or edit a Legal Person.
internal struct AddLegalPerson: View {
    
    /// The context that manages the Core Data in this App
    @Environment(\.managedObjectContext) private var viewContext
    
    /// Whether ther Error when saving is displayed or not.
    @State private var errSavingPresented : Bool = false
    
    /// The Type this View should create a Legal Person for.
    internal var legalPersonType : LegalPerson.LegalPersonType = .none
    
    var body: some View {
        LegalPersonEditor(action: addLegalPerson, legalPersonType: legalPersonType)
            .navigationTitle("Add Legal Person")
            .alert(
                "Error",
                isPresented: $errSavingPresented
            ) {
                
            } message: {
                Text(
                    "Error saving Data.\nPlease try again\n\nIf this Error occurs again, please contact the support."
                )
            }
    }
    
    
    
    /// If all Data are entered this creates and adds the Legal
    /// Person to the Core Data.
    /// If not all Data are entered, this shows an Error Message
    private func addLegalPerson(legalPerson : LegalPerson) -> Void {
        do {
            try viewContext.save()
        } catch _ {
            errSavingPresented.toggle()
        }
    }
}

internal struct AddLegalPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddLegalPerson()
    }
}
