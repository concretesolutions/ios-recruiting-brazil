//
//  NSManagedObject+Extension.swift
//  DataMovie
//
//  Created by Andre Souza on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import CoreData

enum FetchFilter {
    
    case isEqual(attributeName: String, value: String)
    case contains(attributeName: String, value: String)
    
    var predicate: NSPredicate {
        switch self {
        case .isEqual(let attributeName, let value):
            return NSPredicate(format: "%K == %@", argumentArray: [attributeName, value])
        case .contains(let attributeName, let value):
            return NSPredicate(format: "%K CONTAINS[cd] %@", argumentArray: [attributeName, value])
        }
    }
    
}

protocol FetchableProtocol: class {
    associatedtype FetchableType: NSManagedObject = Self
}

extension FetchableProtocol {
    
    func save() {
        CoreDataStack.sharedInstance.saveContext()
    }
    
}

extension FetchableProtocol where Self : NSManagedObject, FetchableType == Self {
    
    
    /**
        The number of elements in the array.
    **/
    
    static func count() -> Int {
        let fetchRequest = NSFetchRequest<FetchableType>(entityName: identifier)
        do {
            let result = try CoreDataStack.sharedInstance.persistentContainer.viewContext.count(for: fetchRequest)
            return result
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
         return 0
    }
    
    
    /**
        Returns an array containing all elements.
    **/
    
    static func fetchAll() -> [FetchableType] {
        let fetchRequest = NSFetchRequest<FetchableType>(entityName: identifier)
        do {
            let array = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest) as [FetchableType]
            return array
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
        
        return []
    }
    
    /**
        Returns a limited number of elements in an array.

        - Parameter offSet: The initial position.
        - Parameter limit: The maximum number of elements.
    **/
    
    static func fetchAll(offSet: Int, limit: Int) -> [FetchableType] {
        let fetchRequest = NSFetchRequest<FetchableType>(entityName: identifier)
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offSet
        do {
            let array = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest) as [FetchableType]
            return array
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
        
        return []
    }
    
    /**
        Returns an array of elements filtered by an attribute.

        - Parameter fetchFilter: The predicate format.
        - Parameter offSet: The initial position.
        - Parameter limit: The maximum number of elements.
    **/
    
    static func findWhere(_ fetchFilter: FetchFilter, offSet: Int? = nil, limit: Int? = nil) -> [FetchableType]? {
        let fetchRequest = NSFetchRequest<FetchableType>(entityName: identifier)
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        if let offSet = offSet {
            fetchRequest.fetchOffset = offSet
        }
        fetchRequest.predicate = fetchFilter.predicate
        do {
            let objct = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest) as [FetchableType]
            return objct
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
        
        return nil
    }
    
    /**
        Delete all CoreData content.
    **/
    
    static func deleteAll() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let coord = context.persistentStoreCoordinator
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: identifier )
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord?.execute(deleteRequest, with: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    /**
        Delete the currente element.
     **/
    
    func delete() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        context.delete(self)
    }
    
}
