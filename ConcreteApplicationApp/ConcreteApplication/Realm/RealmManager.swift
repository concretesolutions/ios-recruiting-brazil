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

    
    
}

