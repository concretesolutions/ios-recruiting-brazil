//
//  DataStore.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
    associatedtype ManagedObject: Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
    associatedtype Query: QueryType = DefaultQuery
}

public enum DefaultQuery: QueryType {
    typealias Descriptor = SortDescriptor
    public var predicate: NSPredicate? {
        return nil
    }
    
    var sortDescriptors: [Descriptor] {
        return []
    }
}

class DataStore: DataStoreProtocol {
    private let realm: Realm
    
    public convenience init() {
        try! self.init(realm: Realm())
        print("Realm is running...")
    }
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    func create<T>(_ value: T, update: Bool) throws where T : Persistable {
        try self.realm.write {
            self.realm.add(value.managedObject(), update: update)
        }
    }
    
    func saveRealmArray<T>(_ objects: [T]) throws where T: Persistable {
        try! self.realm.write {
            let managedObjects = objects.map({ (persistable) -> Object in
                return persistable.managedObject()
            })
            realm.add(managedObjects, update: true)
        }
    }
    
    func read<T>(_ type: T.Type, matching query: T.Query?) -> [T] where T : Persistable {
        var persistedObjects = self.realm.objects(T.ManagedObject.self as! Object.Type)
        if let query = query {
            if let predicate = query.predicate {
                persistedObjects = persistedObjects.filter(predicate)
            }
        }
        var results: [T] = []
        persistedObjects.forEach { (object) in
            let activity = T.init(managedObject: object as! T.ManagedObject)
            results.append(activity)
        }
        return results
    }

    func delete<T>(_ value: T) throws where T : Persistable {
        try self.realm.write {
            guard let objectId = value.managedObject().value(forKey: "id") else { return }
            let results = self.realm.objects(T.ManagedObject.self as Object.Type)
            guard let toDelete = Array(results.filter("id=%@", objectId)).first else { return }
            self.realm.delete(toDelete)
        }
    }

    
    
}
