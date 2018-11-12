//
//  CoreDataManager.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 11/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataManager<T:NSManagedObject>:NSObject {
    
    // MARK: - Properties
    // MARK: Private
    private var modelName = "Concrete"
    
    // MARK: - Init
    override init(){
        super.init()
        
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func get(filter:NSPredicate? = nil) throws -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest   <T>(entityName: entityName)
        
        return try CoreDataSingleton.shared.persistentContainer.viewContext.fetch(fetchRequest)
    }
    
    func exist(predicate:NSPredicate) -> Bool {
        let entityName = String.init(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        do {
            var count = 0
            count = try CoreDataSingleton.shared.persistentContainer.viewContext.count(for: fetchRequest)
            return count == 1
        } catch {
            return false
        }
    }
    
    /// Insert an NSManagedObject in the PersistentStore
    ///
    /// - Parameters:
    ///   - object: object which will be insert in the PersistentStore.
    ///   - predicate: the predicate which must be not fulfill to insert the object. Default value is `nil`
    func insert(object:T) {
        let context = CoreDataSingleton.shared.persistentContainer.viewContext
        
        context.insert(object)
    }
    
    func delete(object:T) {
        let context = CoreDataSingleton.shared.persistentContainer.viewContext
        context.delete(object)
    }
}


