//
//  Persistable.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum PersistError: Error {
    case appDelegateError
}

protocol PersistableModelDelegate {
    var id: Int { get }
    var entityName: String { get }
    func getDictionary() throws -> [String: Any]?
    init(_ managedObject: NSManagedObject)
}

class PersistanceManager {
    static func persist(_ model: PersistableModelDelegate) throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw PersistError.appDelegateError
        }

        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(
            forEntityName: model.entityName,
          in: appDelegate.persistentContainer.viewContext
      )

        let entityObject = NSManagedObject(entity: entity!, insertInto: context)

        for (key, value) in try model.getDictionary()! {
            if key != "entityName" {
                entityObject.setValue(value, forKey: key)
            }
        }

        try context.save()
    }

    static func delete(_ id: Int, from entityName: String) throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw PersistError.appDelegateError
        }

        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)

        let result = try context.fetch(fetchRequest) as! [NSManagedObject]

        context.delete(result[0])

        try context.save()

    }

    static func delete(_ model: PersistableModelDelegate) throws {
        try PersistanceManager.delete(model.id, from: model.entityName)
    }

    static func clear(from entityName: String) throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw PersistError.appDelegateError
        }

        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false

        let result = try context.fetch(fetchRequest) as! [NSManagedObject]

        for objectToDelete in result {
            context.delete(objectToDelete)
        }

        try context.save()
    }

    static func get<T: PersistableModelDelegate>(
        from entityName: String,
        predicates: [NSPredicate] = [],
        compoundBy compoundLogic: NSCompoundPredicate.LogicalType = .and
    ) throws -> [T]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw PersistError.appDelegateError
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if predicates.count > 0 {
            let compoundPredicate = NSCompoundPredicate(type: compoundLogic, subpredicates: predicates)
            fetchRequest.predicate = compoundPredicate
        }

        let response = try managedContext.fetch(fetchRequest)

        return response.map({ T($0) })
    }
}
