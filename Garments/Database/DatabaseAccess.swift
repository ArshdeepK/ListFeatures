//
//  DatabaseAccess.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import Foundation
import CoreData
import UIKit

typealias DatabaseSaveCompletionHandler = ((Error?) -> Void)?

class DatabaseAccess {
  
    // MARK: - Core Data stack
    
    var coreDataStack = CoreDataStack.sharedInstance

    // MARK: - Set Up Core Data
    
    func setup(completion: @escaping () -> Void) {
        coreDataStack.persistentContainer.loadPersistentStores { _, _ in
            DispatchQueue.main.async { completion() }
        }
    }
    
    // MARK: - Fetch From Database
    
    func fetchAllProducts(productSortingKey:SortBy = SortBy.name) -> [Product]? {
        let viewContext = coreDataStack.persistentContainer.viewContext
        let entityName = "Product"
        let fetchRequest = NSFetchRequest<Product>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: productSortingKey.rawValue, ascending: productSortingKey == SortBy.name ? true : false)]
        do {
            let products = try viewContext.fetch(fetchRequest)
            return products

        }catch let error as NSError{
            print("Error in fetching: \(error),\(error.userInfo)")
            return nil
        }
    }
    
    // MARK: - Save In Database

    func saveProduct(name:String, completion: DatabaseSaveCompletionHandler) {
        let viewContext = coreDataStack.mainContext//coreDataStack.persistentContainer.viewContext
        let product = Product(context: viewContext)
        product.name = name
        product.creationDate = Date()//current date
        if viewContext.hasChanges{
            do {
                try viewContext.save()
                completion?(nil)

            }catch let error as NSError{
                print("Failed to save:\(error),\(error.userInfo)")
                completion?(error)
            }
        }
    }
}
