//
//  RealmMovie.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 30/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMovie: Object {
	
	@objc dynamic var movieID: Int = 0
	@objc dynamic var poster : String? = nil
	@objc dynamic var title : String? = nil
	@objc dynamic var descriptionMovie : String? = nil
	@objc dynamic var releaseDate : String? = nil
	var genres : List<Int> = List<Int>()
	@objc dynamic var favorite : Int = 0
	
	static func with(applicationObject: Movie) -> RealmMovie {
		let object = RealmMovie()
		
		object.movieID = applicationObject.movieID
		object.poster = applicationObject.poster
		object.title = applicationObject.title
		object.descriptionMovie =  applicationObject.descriptionMovie
		object.releaseDate = applicationObject.releaseDate
		applicationObject.genres.forEach({ object.genres.append($0) })
		object.favorite = applicationObject.favorite
		
		return object
	}
}

extension Movie {
	init(realmObject: RealmMovie){
		self.movieID = realmObject.movieID
		self.poster = realmObject.poster
		self.releaseDate = realmObject.releaseDate
		self.favorite = realmObject.favorite
		self.descriptionMovie = realmObject.descriptionMovie
		var genres = Array<Int>()
		realmObject.genres.forEach({ genres.append($0) })
		self.genres = genres
		self.title = realmObject.title
		
	}
}
