//
//  CoreDataManager.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 20/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import CoreData

public class CoreDataManager {
    public static var shared = CoreDataManager()

    public var bundle: Bundle? {
        didSet {
            CoreDataManager.shared.persistentContainer = CoreDataManager.shared.loadContainer()
        }
    }
    public var modelName: String? {
        didSet {
            CoreDataManager.shared.persistentContainer = CoreDataManager.shared.loadContainer()
        }
    }

    private init() {}

    lazy public var persistentContainer: NSPersistentContainer? =  loadContainer()

    public static func getContext() throws -> NSManagedObjectContext {
        if let context = shared.persistentContainer?.viewContext {
            return context
        }
        throw CoreDataError.wrongContext
    }

    public func loadContainer() -> NSPersistentContainer? {
        let bundle: Bundle = self.bundle ?? Bundle(for: type(of: self))
        let modelName: String = self.modelName ?? "ConcreteChallenge"

        guard let modelURL = bundle.url(forResource: modelName, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) else {
            print("Error loading model from bundle")
            return nil
        }

        var container: NSPersistentContainer? = NSPersistentContainer(name: modelName, managedObjectModel: model)

        container?.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
                container = nil
            }
        })
        return container
    }

    // MARK: - Core Data Saving support
    public func saveContext() throws {
        guard let context = persistentContainer?.viewContext else {
            throw CoreDataError.wrongContainer
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw CoreDataError.cantSave
            }
        }
    }

}
