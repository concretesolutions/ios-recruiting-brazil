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
	public let title: String?
	public let overview: String?
	public let genreIds: [Int]?
	public let releaseDate: Date?
	
	public let originalTitle: String?
	public let originalLanguage: String?
	
	// Images
	public let posterPath: String?
	public var posterImage: UIImage?
	
	public let backdropPath: String?
	public var backdropImage: UIImage?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case title
		case overview
		case genreIds 			= "genre_ids"
		case releaseDate 		= "release_date"
		case originalTitle 		= "original_title"
		case originalLanguage 	= "original_language"
		case posterPath			= "poster_path"
		case backdropPath		= "backdrop_path"
	}
	
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try? values.decode(Int.self, forKey: .id)
		title = try? values.decode(String.self, forKey: .title)
		overview = try? values.decode(String.self, forKey: .overview)
		genreIds = try? values.decode([Int].self, forKey: .genreIds)
		
		let releaseDateString = try? values.decode(String.self, forKey: .releaseDate)
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.calendar = Calendar(identifier: .iso8601)
		if let unwrappedString = releaseDateString, let date = formatter.date(from: unwrappedString) {
			releaseDate = date
		} else {
			releaseDate = nil
		}
		
		originalTitle = try? values.decode(String.self, forKey: .originalTitle)
		originalLanguage = try? values.decode(String.self, forKey: .originalLanguage)
		
		posterPath = try? values.decode(String.self, forKey: .posterPath)
		backdropPath = try? values.decode(String.self, forKey: .backdropPath)
	}
	
}
