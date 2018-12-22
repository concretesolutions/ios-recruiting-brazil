//
//  RealmManager.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 22/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//


import RealmSwift

class RealmManager{
    
    static let shared = RealmManager()
    private var realm: Realm
    
    private init(){
        self.realm = try! Realm()
    }
    
    func save(object: Object){
        try! realm.write {
            realm.add(object)
        }
    }
    
    func delete(object: Object){
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func update(object: Object){
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func get<T: Object>(objectOf type: T.Type, with primaryKey: Int) -> T? {
        if let object = realm.object(ofType: type, forPrimaryKey: primaryKey){
            return object
        }
        return nil
    }
    
    func getAll<T: Object>(objectsOf type: T.Type) -> Results<T> {
        return realm.objects(type)
    }

    
    
}

