//
//  Movie.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

public struct Movie {
	public var id: Int
	public var title: String
	public var overview: String?
	public var releaseDate: Date
	public var posterPath: String?
	public var backdropPath: String?
	public var genreIDs: [Int]
	
	public init(id: Int, title: String, overview: String?, releaseDate: Date, posterPath: String?, backdropPath: String?, genreIDs: [Int]?) {
		self.id = id
		self.title = title
		self.overview = overview
		self.releaseDate = releaseDate
		self.posterPath = posterPath
		self.backdropPath = backdropPath
		if let genreIDs = genreIDs {
			self.genreIDs = genreIDs
		} else {
			self.genreIDs = []
		}
	}
	
}

extension Movie: Codable {
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case title = "title"
		case genreIDs = "genre_ids"
		case overview = "overview"
		case releaseDate = "release_date"
		case posterPath = "poster_path"
		case backdropPath = "backdrop_path"
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.id = try container.decode(Int.self, forKey: .id)
		self.title = try container.decode(String.self, forKey: .title)
		self.overview = try? container.decode(String.self, forKey: .overview)
		self.releaseDate = try container.decode(Date.self, forKey: .releaseDate)
		self.posterPath = try? container.decode(String.self, forKey: .posterPath)
		self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
		self.genreIDs = try container.decode(Array<Int>.self, forKey: .genreIDs)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.id, forKey: .id)
		try container.encode(self.title, forKey: .title)
		try? container.encode(self.overview, forKey: .overview)
		try container.encode(self.releaseDate, forKey: .releaseDate)
		try? container.encode(self.posterPath, forKey: .posterPath)
		try? container.encode(self.backdropPath, forKey: .backdropPath)
		try container.encode(self.genreIDs, forKey: .genreIDs)
	}
}
