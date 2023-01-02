//
//  EditLegalPerson.swift
//  Financer
//
//  Created by Julian Schumacher on 01.01.23.
//

import SwiftUI

/// The View to edit a Legal Person
internal struct EditLegalPerson: View {
    
    /// The View Context to interact with Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    /// The LegalPersonWrapper in the Environment
    @EnvironmentObject private var legalPersonWrapper : LegalPersonWrapper
    
    /// Whether ther Error when saving is displayed or not.
    @State private var errSavingPresented : Bool = false
    
    var body: some View {
        LegalPersonEditor(action: editLegalPerson, legalPerson: legalPersonWrapper.legalPerson!)
            .navigationTitle("Edit \(legalPersonWrapper.legalPerson!.name!)")
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
    
    /// The action that is passed to the Legal Person
    /// Editor and edits a Legal Person
    private func editLegalPerson(legalPerson : LegalPerson) -> Void {
        legalPerson.finances = legalPersonWrapper.legalPerson!.finances
        viewContext.delete(legalPersonWrapper.legalPerson!)
        legalPersonWrapper.legalPerson = legalPerson
        do {
            try viewContext.save()
        } catch _ {
            errSavingPresented.toggle()
        }
    }
}

struct EditLegalPerson_Previews: PreviewProvider {
    static var previews: some View {
        EditLegalPerson()
    }
}
