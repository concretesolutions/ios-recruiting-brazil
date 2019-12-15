//
//  NSPersistentContainerMock.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 14/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import CoreData

class NSPersistentContainerMock: NSPersistentContainer {
    
    // MARK: - Initializers and Deinitializers
    
    override init(name: String, managedObjectModel: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: managedObjectModel)
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        self.persistentStoreDescriptions = [description]
        self.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)
            if let error = error {
                fatalError("Failed to create an in-memory coordinator with error: \(error).")
            }
        }
    }
}
