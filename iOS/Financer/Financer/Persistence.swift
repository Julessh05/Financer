//
//  Persistence.swift
//  Financer
//
//  Created by Julian Schumacher on 21.12.22.
//

import CoreData

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
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Finance(context: viewContext)
            newItem.amount = 100
        }
        do {
            try viewContext.save()
        } catch {
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
    let container: NSPersistentCloudKitContainer

    /// The Standard Init Method
    /// to create a new persistence Controller
    private init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Financer")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
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
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
