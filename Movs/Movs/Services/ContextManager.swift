//
//  ContextManager.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import CoreData

class ContextManager: NSObject {
  
  // MARK: - Core Data stack
  static let shared = ContextManager()
  
  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "Movs")
    container.loadPersistentStores(completionHandler: { (_, error) in
      container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      if let error = error as NSError? {
        print("Error trying to create core data persistent container in: \(ContextManager.self)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch let error{
        print("Error trying to save core data context in: \(ContextManager.self)")
        print(error.localizedDescription)
      }
    }
  }
}
