//
//  CoreDataStack.swift
//  GenresFeature
//
//  Created by Marcos Felipe Souza on 19/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    private let modelName: String =  "GenresFeature"
    private init() {}
    
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    var savingContext: NSManagedObjectContext {
        return storeContainer.newBackgroundContext()
    }
    
    var storeURL : URL? {
        guard let modelURL = Bundle(identifier: "com.mfelipesp.GenresFeature")?.url(forResource: modelName, withExtension: "momd") else {
            debugPrint(" Failed to load DataModel")
                return nil
        }
        
        return modelURL
        
    }
    
    lazy var storeDescription: NSPersistentStoreDescription? = {
        
        guard let storeURL = self.storeURL else { return nil }
        
        let description = NSPersistentStoreDescription(url: storeURL)
        
        //Apenas para Migration
        description.shouldMigrateStoreAutomatically = true
        //description.shouldInferMappingModelAutomatically = false
        
        return description
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        var storeDescriptions = [NSPersistentStoreDescription]()
    
        if let storeDescription = self.storeDescription {
            storeDescriptions = [storeDescription]
        }
        
        container.persistentStoreDescriptions = storeDescriptions
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                debugPrint("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    func saveContext() throws {
        guard managedContext.hasChanges else { return }        
        do {
            try managedContext.save()
        } catch let error as NSError {
            throw error
        }
    }
}
