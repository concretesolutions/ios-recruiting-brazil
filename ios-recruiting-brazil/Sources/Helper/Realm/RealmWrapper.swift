//
//  RealmWrapper.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

extension Results {
    func toArray() -> [Results.Iterator.Element] {
        return map { $0 }
    }
}

class RealmWrapper {

    static func update(_ obj: Object) -> Bool {
        guard let realm = realm() else { return false }

        do {
            _ = try realm.write { () -> Void in
                realm.add(obj, update: true)
            }
            return true
        } catch {
            return false
        }
    }

    static func update(_ obj: [Object]) -> Bool {
        guard let realm = realm() else { return false }
        var result = true
        obj.forEach { _ in
            do {
                _ = try realm.write { () -> Void in
                    realm.add(obj, update: true)
                }
            } catch {
                result = false
            }
        }
        return result
    }

    static func write(_ obj: Object) -> Bool {
        guard let realm = realm() else { return false }

        do {
            _ = try realm.write { () -> Void in
                realm.add(obj, update: false)
            }
            return true
        } catch {
            return false
        }
    }

    static func delete(_ obj: Object) -> Bool {
        guard let realm = realm() else { return false }

        do {
            _ = try realm.write { () -> Void in
                realm.delete(obj)
            }
            return true
        } catch {
            return false
        }
    }

    static func clearAll() {
        guard let realm = realm() else { return }

        do {
            _ = try realm.write { () -> Void in
                realm.deleteAll()
            }
        } catch {
            print("Could not clear realm database")
        }
    }

    static func read<T: Object>(_ type: T.Type) throws -> Results<T> {
        if let realm = self.realm() {
            return realm.objects(type as T.Type)
        } else {
            throw DataError.realm(message: "the Realm can't be instancied")
        }
    }
    
    static func read<T: Object>(_ type: T.Type, filter: String) throws -> Results<T> {
        if let realm = self.realm() {
            let result = realm.objects(type as T.Type).filter(filter)
            if result.count > 0 {
                return result
            } else {
                throw DataError.realm(message: "item not found")
            }
        } else {
            throw DataError.realm(message: "the Realm can't be instancied")
        }
    }
    
    static func readFirst<T: Object>(_ type: T.Type, filter: String) throws -> T {
        if let realm = self.realm() {
            let result = realm.objects(type as T.Type).filter(filter)
            if let item = result.first {
                return item
            } else {
                throw DataError.realm(message: "item not found")
            }
        } else {
            throw DataError.realm(message: "the Realm can't be instancied")
        }
    }
    
    static func remove<T: Object>(_ type: T.Type, filter: String) throws -> Bool {
        do {
            let object = try RealmWrapper.readFirst(type, filter: filter)
            if RealmWrapper.delete(object) {
                return true
            } else {
                throw DataError.realm(message: "item not removed")
            }
        } catch let error {
            throw error
        }
    }

    fileprivate static func removeRealm() -> Bool {
        let success: Bool

        if let path = Realm.Configuration.defaultConfiguration.fileURL?.path {
            do {
                try FileManager().removeItem(atPath: path)
                success = true
            } catch {
                success = false
            }
        } else {
            success = false
        }

        return success
    }

    static func realm() -> Realm? {
        let realmResponse: Realm?

        do {
            try realmResponse = Realm()
        } catch {
            _ = removeRealm()
            realmResponse = try? Realm()
        }

        return realmResponse
    }
}
