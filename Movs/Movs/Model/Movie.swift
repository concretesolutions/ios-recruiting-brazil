//
//  Movie.swift
//  Movs
//
//  Created by Lucas Ferraço on 13/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class Movie: Decodable {
	
	public let id: Int?
	
	public let localizedTitle: String?
	public let originalTitle: String?
	
	public let voteAverage: Double?
	public let overview: String?
	public var genres: [String]?
	public let releaseDate: Date?
	public let originalLanguage: String?
	
	// Images
	public var posterImageData: Data?
	public var backdropImageData: Data?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case localizedTitle		= "title"
		case originalTitle 		= "original_title"
		case voteAverage		= "vote_average"
		case overview
		case releaseDate 		= "release_date"
		case originalLanguage 	= "original_language"
	}
	
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try? values.decode(Int.self, forKey: .id)
		localizedTitle = try? values.decode(String.self, forKey: .localizedTitle)
		originalTitle = try? values.decode(String.self, forKey: .originalTitle)
		voteAverage = try? values.decode(Double.self, forKey: .voteAverage)
		overview = try? values.decode(String.self, forKey: .overview)
		originalLanguage = try? values.decode(String.self, forKey: .originalLanguage)
		
		let releaseDateString = try? values.decode(String.self, forKey: .releaseDate)
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.calendar = Calendar(identifier: .iso8601)
		if let unwrappedString = releaseDateString, let date = formatter.date(from: unwrappedString) {
			releaseDate = date
		} else {
			releaseDate = nil
		}
	}
	
}
