//
//  Genre.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

public struct Genre {
	public var id: Int
	public var name: String
	
	public init(id: Int, name: String) {
		self.id = id
		self.name = name
	}
}

extension Genre : Codable {
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.id, forKey: .id)
		try container.encode(self.name, forKey: .name)
	}
	
}
