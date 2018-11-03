//
//  MovieProvider.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 22/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import Foundation
import RealmSwift


final class MovieProvider: Provider {
	typealias T = Movie
	
	var values: [Movie] {
		get {
			let realm = try! Realm()
			let realmMovie = realm.objects(RealmMovie.self)
			let movies = Array(realmMovie.map{Movie.init(realmObject: $0)})
			
			return movies
		}
		
		set {
			let realm = try! Realm()
			let everyone = realm.objects(RealmMovie.self)
			
			try! realm.write {
				realm.delete(everyone)
			}
			
			newValue.forEach({ insert($0) })
		}
	}
	
	func insert(_ object: Movie) {
		let movie = RealmMovie.with(applicationObject: object)
		let realm = try! Realm()
		
		try! realm.write {
			realm.add(movie)
		}
	}
	
	func delete(_ object: Movie) {
		let movie = RealmMovie.with(applicationObject: object)
		let realm = try! Realm()
		
		try! realm.write {
			realm.delete(realm.objects(RealmMovie.self).filter("movieID=%@", movie.movieID))
		}
	}
	
	func update(_ object: Movie, oldID: Int) {
		let movie = RealmMovie.with(applicationObject: object)
		let realm = try! Realm()
		
		try! realm.write {
			realm.delete(realm.objects(RealmMovie.self).filter("movieID=%@", movie.movieID))
		}
		
		try! realm.write {
			realm.add(movie)
		}
	}
	
	func get(_ withID: Int) -> Movie? {
		let realm = try! Realm()
		let objects = realm.objects(RealmMovie.self).filter("movieID=%@", withID)
		
		return Array(objects.map({ Movie.init(realmObject: $0) }) ).first
	}
	
}
