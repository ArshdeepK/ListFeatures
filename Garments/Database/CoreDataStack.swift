//
//  CoreDataStack.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-26.
//

import Foundation
import CoreData

class CoreDataStack {
    class var sharedInstance: CoreDataStack {
        struct Static {
            static let instance = CoreDataStack()
        }
        return Static.instance
    }
    static let containerName = "Garments"
    
    lazy var persistentContainer: NSPersistentContainer = {
        if CONFIG.SELECTED == .RUN {
            return NSPersistentContainer(name: CoreDataStack.containerName)
        }
        else {
            let persistentStoreDescription = NSPersistentStoreDescription()
            
            /// Ensures that the managed object context is only for testing
            persistentStoreDescription.type = NSInMemoryStoreType
            
            let container = NSPersistentContainer(name: CoreDataStack.containerName)
            container.persistentStoreDescriptions = [persistentStoreDescription]
            container.loadPersistentStores { _, _ in }
            return container
        }
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        if CONFIG.SELECTED == .RUN {
            let context = persistentContainer.viewContext
            context.automaticallyMergesChangesFromParent = true
            return context
        }
        else {
            return persistentContainer.viewContext
        }
    }()
        
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
