//
//  Provider.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 30/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import Foundation

public protocol Provider {
	associatedtype T: PD_Type
	var values: [T] { get set }
	func insert(_ object: T)
	func delete(_ object: T)
	func update(_ object: T, oldID: Int)
	func get(_ withID: Int) -> T?
}
