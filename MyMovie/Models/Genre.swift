//
//  Genre.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 24/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

public struct Genre: Codable, PD_Type, Hashable {
	
	var genreID:Int
	var name:String?
	public var hashValue: Int {
		return genreID.hashValue
	}
	
	public enum CodingKeys: String, CodingKey {
		case genreID = "id"
		case name = "name"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		genreID = try values.decode(Int.self, forKey: .genreID)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}
	
	init(genreID: Int, name: String) {
		self.genreID = genreID
		self.name = name
	}
	
	public var formattedDescription: String {
		return self.name ?? "Sem Genero"
	}
}
