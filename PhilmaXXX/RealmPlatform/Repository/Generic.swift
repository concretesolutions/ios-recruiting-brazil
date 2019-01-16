//
//  BaseRepository.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmRepository {
	associatedtype T: RealmRepresentable
	func get() -> [T]
	func upsert(object: T)
	func delete(object: T)
}
