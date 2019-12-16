// swiftlint:disable identifier_name

//
//  NSPersistentContainerMock.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 14/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import CoreData
@testable import Movs

class NSPersistentContainerMock: NSPersistentContainer {
        
    // MARK: - Properties
    
    var saveNotificationCompletion: ((Notification) -> Void)?
    
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

        NotificationCenter.default.addObserver(self, selector: #selector(didSaveContext(_:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil )
    }
    
    func waitForSavedNotification(completion: @escaping ((Notification) -> Void)) {
        self.saveNotificationCompletion = completion
    }
    
    @objc func didSaveContext(_ notification: Notification) {
        self.saveNotificationCompletion?(notification)
    }
        
    // MARK: - Stubs and Flush
    
    func addDataStubs() {
        for id in 1...5 {
            self.addFavoriteMovie(id: id, genres: [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Horror")])
        }
        self.save()
    }
    
    func flushData() {
        let fetchAllFavorites = NSFetchRequest<Movs.CDFavoriteMovie>(entityName: "CDFavoriteMovie")
        let fetchResults: [Movs.CDFavoriteMovie]
        do {
            fetchResults = try self.viewContext.fetch(fetchAllFavorites)
        } catch {
            fetchResults = []
        }

        for object in fetchResults {
            self.viewContext.delete(object)
        }
        
        self.save()
    }
    
    // MARK: - Helpers
    
    private func addFavoriteMovie(id: Int, genres: [Genre]) {
        guard let description = NSEntityDescription.entity(forEntityName: "CDFavoriteMovie", in: self.viewContext) else {
            fatalError("Failed to retrieve CDFavoriteMovie in current context")
        }

        let instance = CDFavoriteMovie(entity: description, insertInto: self.viewContext)
        instance.id = Int64(id)
        instance.genreIDs = NSSet(array: genres)
    }
    
    private func save() {
        do {
            try self.viewContext.save()
        } catch {
            fatalError("Unresolved error: \(error).")
        }
    }
}
