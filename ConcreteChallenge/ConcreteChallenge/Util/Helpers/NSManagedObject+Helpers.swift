//
//  NSManagedObject+Helpers.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 20/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import CoreData

extension NSManagedObject {

    convenience init(saving: Bool = true) throws {
        let context = try CoreDataManager.getContext()
        if let entity = NSEntityDescription.entity(forEntityName: String(describing: type(of: self)), in: context) {
            self.init(entity: entity, insertInto: saving ? context : nil)
        } else {
            throw CoreDataError.wrongEntityName
        }
    }

    public func delete() throws {
        let context = try CoreDataManager.getContext()
        context.delete(self)

        do {
            try context.save()
        } catch {
            throw CoreDataError.cantDeleteObject
        }
    }

    public static func query<T: NSManagedObject>(predicate: NSPredicate? = nil,
                                                 sortDescriptors: [NSSortDescriptor]? = nil) throws -> [T] {
        let context = try CoreDataManager.getContext()
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors

        if let result = try? context.fetch(request) {
            if let resultObject = result as? [T] {
                return resultObject
            }
        }
        throw CoreDataError.wrongFetch
    }

    public static func all<T: NSManagedObject>() throws -> [T] {
        return try query()
    }

    @discardableResult
    public static func queryById<T: NSManagedObject>(_ id: Int) throws -> T? {
        let predicate = NSPredicate(format: "id == %d", id)
        let saved: [T] = try query(predicate: predicate)

        if saved.count > 0 {
            return saved.first!
        }
        return nil
    }

    public static func deleteAll() throws {
        let managedContext = try CoreDataManager.getContext()

        if let name = entity().name {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let results = try managedContext.fetch(fetchRequest)
                for managedObject in results {
                    if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                        managedContext.delete(managedObjectData)
                    }
                }
                try managedContext.save()
            } catch {
                throw CoreDataError.cantDeleteObject
            }
        } else {
            throw CoreDataError.wrongEntityName
        }
    }
}
