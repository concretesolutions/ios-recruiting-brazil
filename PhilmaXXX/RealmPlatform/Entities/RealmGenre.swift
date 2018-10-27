//
//  RealmGenre.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

final class RealmGenre: Object {
	@objc dynamic var id: Int = 0
	@objc dynamic var name: String = ""
	
	override static func primaryKey() -> String {
		return "id"
	}
}

extension RealmGenre: DomainRepresentableType {
	typealias TMDB_Entity = Genre
	
	func baseData() -> Genre {
		let data = Genre(id: self.id, name: self.name)
		return data
	}
}

extension Genre: RealmRepresentable {
	typealias RealmType = RealmGenre
	
	func realmData() -> RealmGenre {
		let data = RealmGenre()
		data.id = self.id
		data.name = self.name
		return data
	}
}
