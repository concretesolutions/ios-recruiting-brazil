//
//  RealmManager.swift
//  Movs
//
//  Created by Erick Lozano Borges on 11/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import RealmSwift

//FIXME: Throw Errors
class RealmManager {
    
    static let shared = RealmManager()
    private var db: Realm
    
    private init() {
        //FIXME: migration error
        db = try! Realm()
    }
    
    func create(_ object: Object) {
        try! db.write {
            db.add(object)
        }
    }
    
    func update(_ object: Object) {
        try! db.write {
            db.add(object, update: true)
        }
    }
    
    func getAll<T: Object>(_ type: T.Type) -> Results<T> {
        return db.objects(type)
    }
    
    func get<T: Object>(_ type: T.Type , withPrimaryKey primaryKey: Int) -> T? {
        return db.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    /**
     Remember to get the exact same Object to delete
     */
    func delete(_ object: Object) {
        try! db.write {
            db.delete(object, cascading: true)
        }
    }
    
}
