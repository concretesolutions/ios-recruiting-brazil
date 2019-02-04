//
//  DatabaseManager.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import CoreData

class DatabaseManager<T:NSManagedObject>: NSObject {
  
  // MARK: - Properties
  // MARK: Private
  private let contextManager: ContextManager
  
  var viewContext: NSManagedObjectContext {
    return contextManager.persistentContainer.viewContext
  }
  
  // MARK: - Init
  init(contextManager: ContextManager = ContextManager()) {
    self.contextManager = contextManager
    super.init()
  }
  
  // MARK: - Functions
  // MARK: Private
  
  
  // MARK: Public
  /// Fetch all NSManagedObjects and return a list of them
  ///
  /// - Parameter filter: Apply a filter in the fetch, by default it's nil
  /// - Returns: Return a list of NSManagedObjects
  func fetch(filter: NSPredicate? = nil) -> [T] {
    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
    if let predicate = filter{
      fetchRequest.predicate = predicate
    }
    do {
      return try viewContext.fetch(fetchRequest)
    } catch {
      print("Error trying to fetch \(T.self) in: \(DatabaseManager.self)")
    }
    return []
  }
  
  
  /// Update the commited changes, by saving the context
  func update() {
    contextManager.saveContext()
  }
  
  
  /// Insert an NSManagedObject in the CoreData
  ///
  /// - Parameters:
  ///   - object: object which will be insert in the PersistentStore.
  func insert(object: T) {
    let context = viewContext
    context.insert(object)
    update()
  }
  
  /// Delete an NSManagedObjects in the CoreData
  ///
  /// - Parameter object: object which will be deleted in the PersistentStore.
  func delete(object: T) {
    let context = viewContext
    context.delete(object)
    update()
  }
  
  /// Checks if an NSManagedObject with a given predicate exist
  ///
  /// - Parameter id: The filter to find an specific NSManagedObject
  /// - Returns: return true if it finds and NSManagedObject with the predicate, false if it don't
  func exist(id: Int) -> Bool {
    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
    fetchRequest.predicate = NSPredicate(format: "id = %@", id.description)
    do {
      var count = 0
      count = try viewContext.count(for: fetchRequest)
      return count == 1
    } catch {
      return false
    }
  }
}
