//
//  GenresRepository.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

public final class GenresRepository: RealmRepository {
	typealias T = Genre
	let realm : Realm
	
	init(realm: Realm){
		self.realm = realm
	}
	
	func get() -> [Genre] {
		let realmObjects = realm.objects(Genre.RealmType.self)
		let objects = Array(realmObjects.map({ return $0.baseData() }))
		return objects
	}
	
	func set(objects: [Genre]){
		self.deleteAll()
		let realmObjects = objects.map({ $0.realmData() })
		try! realm.write {
			realm.add(realmObjects, update: true)
		}
	}
	
	func deleteAll(){
		let allObjects = realm.objects(RealmGenre.self)
		try! realm.write {
			realm.delete(allObjects)
		}
	}
	
	func upsert(object: Genre) {
		let realmObject = object.realmData()
		try! realm.write {
			realm.add(realmObject, update: true)
		}
	}
	
	func delete(object: Genre) {
		let realmObject = realm.object(ofType: Genre.RealmType.self, forPrimaryKey: object.id)
		
		if realmObject != nil {
			try! realm.write {
				realm.delete(realmObject!)
			}
		}
	}
	
	func get(with IDs: [Int]) -> [Genre]{
		let predicate = NSPredicate(format: "id IN %@", IDs)
		let realmObjects = realm.objects(Genre.RealmType.self).filter(predicate)
		let objects = Array(realmObjects.map({ $0.baseData() }))
		return objects
	}
	
}
