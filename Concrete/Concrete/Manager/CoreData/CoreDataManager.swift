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
    private var context:NSManagedObjectContext
    
    // MARK: - Init
    override init(){
        self.context = CoreDataSingleton.shared.persistentContainer.viewContext
        
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    
    func get(filter:NSPredicate? = nil) throws -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        if let predicate = filter{
            fetchRequest.predicate = predicate
        }
        
        return try self.context.fetch(fetchRequest)
    }
    
    func exist(predicate:NSPredicate) -> Bool {
        let entityName = String.init(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        do {
            var count = 0
            count = try self.context.count(for: fetchRequest)
            return count == 1
        } catch {
            return false
        }
    }
    
    func insert(object:T, predicate:NSPredicate? = nil) {
        if let predicate = predicate {
            if !self.exist(predicate: predicate) {
                self.context.insert(object)
            }
        }else{
            self.context.insert(object)
        }
    }
    
    func insert(objects:[T]) {
        for object in objects {
            self.insert(object: object)
        }
    }
    
    func delete(object:T) {
        let context = self.context
        context.delete(object)
    }
    
    func save() throws {
        try self.context.save()
    }
}
