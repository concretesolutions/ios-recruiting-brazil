//
//  Hashable.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

extension Movie: Hashable {
	public static func == (lhs: Movie, rhs: Movie) -> Bool {
		return (lhs.hashValue == rhs.hashValue)
	}
	
	public var hashValue: Int {
		return id.hashValue
	}
}

extension Genre: Hashable {
	public static func == (lhs: Genre, rhs: Genre) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
	
	public var hashValue: Int {
		return id.hashValue
	}
}
