//
//  CoreDataManager.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 18/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataManager<T:NSManagedObject> : NSObject{
    
    // MARK: - Properties
    // MARK: Private
    
    // MARK: - Init
    override init(){
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    
    
    // MARK: Public
    /// Fetch all NSManagedObjects and return a list of them
    ///
    /// - Parameter filter: Apply a filter in the fetch, by default it's nil
    /// - Returns: Return a list of NSManagedObjects
    func fetch(filter:NSPredicate? = nil) -> [T] {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        if let predicate = filter{
            fetchRequest.predicate = predicate
        }
        do {
            return try CoreDataContextManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error trying to fetch \(T.self) in: \(CoreDataManager.self)")
        }
        return []
    }
    
    
    /// Update the commited changes, by saving the context
    func update(){
        CoreDataContextManager.shared.saveContext()
    }
    
    
    /// Insert an NSManagedObject in the CoreData
    ///
    /// - Parameters:
    ///   - object: object which will be insert in the PersistentStore.
    func insert(object:T) {
        let context = CoreDataContextManager.shared.persistentContainer.viewContext
        context.insert(object)
        update()
    }
    
    /// Delete an NSManagedObjects in the CoreData
    ///
    /// - Parameter object: object which will be deleted in the PersistentStore.
    func delete(object:T) {
        let context = CoreDataContextManager.shared.persistentContainer.viewContext
        context.delete(object)
        update()
    }
    
    /// Checks if an NSManagedObject with a given predicate exist
    ///
    /// - Parameter predicate: The filter to find an specific NSManagedObject
    /// - Returns: return true if it finds and NSManagedObject with the predicate, false if it don't
    func exist(predicate:NSPredicate) -> Bool {
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.predicate = predicate
        do {
            var count = 0
            count = try CoreDataContextManager.shared.persistentContainer.viewContext.count(for: fetchRequest)
            return count == 1
        } catch {
            return false
        }
    }
    
}
