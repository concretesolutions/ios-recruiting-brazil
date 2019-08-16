//
//  RealmManager.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import RealmSwift

class RealmManager {

    static let shared = RealmManager()
    private var realm: Realm?

    private init() {
        do {
            self.realm = try Realm()
        } catch {
            // handle error
        }
    }

    func save(object: Object) {
        guard let realm = realm else {
            return
        }
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
        }
    }

    func delete(object: Object) {
        guard let realm = realm else {
            return
        }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
        }
    }

    func update(object: Object) {
        guard let realm = realm else {
            return
        }
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
        }
    }

    func get<T: Object>(objectOf type: T.Type, with primaryKey: Int) -> T? {
        if let object = realm?.object(ofType: type, forPrimaryKey: primaryKey) {
            return object
        }
        return nil
    }

    func getAll<T: Object>(objectsOf type: T.Type) -> Results<T>? {
        guard let realm = realm else {
            return nil
        }
        return realm.objects(type)
    }
}
