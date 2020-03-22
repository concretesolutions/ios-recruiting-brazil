//
//  DataController.swift
//  GenresFeature
//
//  Created by Marcos Felipe Souza on 20/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import CoreData
open class DataController: NSObject {
    
    public var managedObjectContext: NSManagedObjectContext
    public var modelName: String
    public init(modelName: String,
                bundle: Bundle,
                completionClosure: @escaping () -> ()) throws {
        //This resource is the same name as your xcdatamodeld contained in your project
        self.modelName = modelName
                
        guard let modelURL = bundle.url(forResource: modelName, withExtension:"momd") else {
            throw NSError(domain: "DataController -- Error loading model from bundle", code: 1, userInfo: nil)
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            throw NSError(domain: "DataController -- Error initializing mom from: \(modelURL)", code: 2, userInfo: nil)
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent("\(modelName).sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
                DispatchQueue.main.sync(execute: completionClosure)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
}
