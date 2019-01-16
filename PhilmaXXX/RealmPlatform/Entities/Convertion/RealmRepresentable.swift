//
//  RealmRepresentable.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
	associatedtype RealmType: DomainRepresentableType
	
	func realmData() -> RealmType
}
