//
//  RealmMovie.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

public final class RealmMovie: Object {
	@objc dynamic var id: Int = 0
	@objc dynamic var title: String = ""
	@objc dynamic var overview: String? = nil
	@objc dynamic var releaseDate: Date? = nil
	@objc dynamic var posterPath: String? = nil
	@objc dynamic var backdropPath: String? = nil
	var genreIDs: List<Int> = List<Int>()
	
	override public static func primaryKey() -> String {
		return "id"
	}
}

extension RealmMovie: DomainRepresentableType {
	typealias TMDB_Entity = Movie
	
	func baseData() -> Movie {
		let data = Movie(id: self.id, title: self.title, overview: self.overview, releaseDate: self.releaseDate, posterPath: self.posterPath, backdropPath: self.backdropPath, genreIDs: Array(genreIDs))
		return data
	}
}

extension Movie: RealmRepresentable {
	typealias RealmType = RealmMovie
	
	func realmData() -> RealmMovie {
		let data = RealmMovie()
		data.id = self.id
		data.title = self.title
		data.overview = self.overview
		data.releaseDate = self.releaseDate
		data.posterPath = self.posterPath
		data.backdropPath = self.backdropPath
		self.genreIDs.forEach({ data.genreIDs.append($0) })
		return data
	}
}
