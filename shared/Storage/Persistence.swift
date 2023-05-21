//
//  Persistence.swift
//  Financer
//
//  Created by Julian Schumacher on 21.12.22.
//

import CoreData
import SwiftUI

/// This struct represents the Controller to manage
/// the Code Data Objects and Storage
internal struct PersistenceController {
    
    /// The shared singleton Object which is used across
    /// this App.
    ///
    /// Because the initializer is private, this is the only
    /// persistence controller used in this App.
    static let shared = PersistenceController()
    
    /// This is just a Persistence Controller for the previews
    /// used while developing the App.
    ///
    /// This SHOULD NEVER BE USED in production Code, because
    /// it contains a fatalError() Method which would crash the App
    /// if something went wrong while storing the Data.
    static var preview: PersistenceController = {
        // Set location to /dev/null for preview.
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // Add some Data
        let legalPerson = Person(context: viewContext)
        legalPerson.name = "Test Person"
        let phone : String = "+123456789"
        let notes : String = "Test Notes"
        let url : URL? = URL(string: "https://github.com/Julessh05/Financer")
        for _ in 0 ..< 5 {
            // Add Finances
            let i = Income(context: viewContext)
            let e = Expense(context: viewContext)
            i.amount = 100
            i.legalPerson = legalPerson
            e.amount = 10
            e.legalPerson = legalPerson
            i.notes = notes
            e.notes = notes
            i.automaticGenerated = false
            e.automaticGenerated = false
            i.periodDuration = 0
            e.periodDuration = 31
            i.date = Date()
            e.date = Date()
            
            // Add Legal Persons
            let p = Person(context: viewContext)
            let c = Company(context: viewContext)
            let o = Organization(context: viewContext)
            p.name = "Person"
            c.name = "Company"
            o.name = "Organization"
            p.phone = phone
            c.phone = phone
            o.phone = phone
            p.notes = notes
            c.notes = notes
            o.notes = notes
            c.url = url
            o.url = url
        }
        // try to save the Data.
        do {
            try viewContext.save()
        } catch {
            // Crash App if Error appears in preview Controller.
            // A Log should be generated alongside the console output.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    /// The Container that holds all the Information
    /// and represents the Storage itself.
    ///
    /// This is a Cloud Kit Container to mirror the changes
    /// to the User's iCloud.
    internal let container: NSPersistentCloudKitContainer
    
    /// The Standard Init Method
    /// to create a new persistence Controller.
    ///
    /// The inMemory Parameter should only be set to true
    /// for internal develop and test reasons, otherwise it will cause
    /// uninteded behaviour.
    private init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Financer")
        // If the inMemory Parameter is true,
        // the container is stored to /dev/null which means is disappears and
        // can't be found again.
        //
        // This should only be used in internal preview or test scenarios.
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // NSPersistentStoreFileProtectionKey is not available
        // in macOS, so this is only compiled and added, if the OS
        // is not macOS
#if !os(macOS)
        // Core Data Encryption Idea from: https://cocoacasts.com/is-core-data-encrypted
        container.persistentStoreDescriptions.first!.setOption(
            FileProtectionType.complete as NSObject,
            forKey: NSPersistentStoreFileProtectionKey
        )
#endif
        // Load Data
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        // Automatically merge Changes.
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // Idea for this merge policy: https://www.reddit.com/r/iOSProgramming/comments/egki07/which_merge_policy_should_i_use_for_cloudkitcore/
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    /// Erases all Content stored in the Core Data
    internal func eraseAllContent() throws -> Void {
        try container.viewContext.save()
    }
    
    internal func checkFinanceDeletion(finance : Finance) -> Void {
        if finance.isPeriodical {
            
        } else {
            
        }
    }
    
    /// Deletes the specified Finance, if necessary all connected Finances
    /// and saves it to the System.
    internal func deleteFinance(
        _ finance : Finance,
        userWrapper : EnvironmentObject<UserWrapper>,
        financeWrapper : EnvironmentObject<FinanceWrapper>
    ) throws -> Void {
        if financeWrapper.wrappedValue.finance == finance {
            financeWrapper.wrappedValue.finance = nil
        }
        if finance.isPeriodical {
            for financeToDelete in finance.periodicallyConnectedFinances?.allObjects as! [Finance] {
                container.viewContext.delete(financeToDelete)
                userWrapper.wrappedValue.removeFinance(financeToDelete)
            }
        }
        userWrapper.wrappedValue.removeFinance(finance)
        try deleteAndSave(object: finance)
    }
    
    /// Deletes the specified Legal Person and all connected Finances
    /// and saves it to the System.
    internal func deleteLegalPerson(_ legalPerson : LegalPerson) throws -> Void {
        try deleteAndSave(object: legalPerson)
    }
    
    /// Deletes the specified User from the System.
    internal func deleteUser(_ user : User) throws -> Void {
        try deleteAndSave(object: user)
    }
    
    /// Actually deletes the specified Object and updates
    /// Core Data.
    private func deleteAndSave(object: NSManagedObject) throws -> Void {
        container.viewContext.delete(object)
        try save()
    }
    
    /// Saves the Data in this App
    internal func save() throws -> Void {
        try container.viewContext.save()
    }
}
