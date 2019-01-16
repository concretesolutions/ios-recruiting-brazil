//
//  FavoritesRepository.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

public final class FavoritesRepository : RealmRepository {
	typealias T = Movie
	let realm : Realm
	
	init(realm: Realm){
		self.realm = realm
	}
	
	func get() -> [Movie] {
		let realmObjects = realm.objects(Movie.RealmType.self)
		let objects = Array(realmObjects.map({ return $0.baseData() }))
		return objects
	}
	
	func upsert(object: Movie) {
		let realmObject = object.realmData()
		
		try! realm.write {
			realm.add(realmObject, update: true)
		}
	}
	
	func delete(object: Movie) {
		let realmObject = realm.object(ofType: Movie.RealmType.self, forPrimaryKey: object.id)
		
		if realmObject != nil {
			try! realm.write {
				realm.delete(realmObject!)
			}
		}
	}
	
	func deleteAll(){
		let allObjects = realm.objects(RealmMovie.self)
		
		try! realm.write {
			realm.delete(allObjects)
		}
	}
	
}
