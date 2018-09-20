//
//  TMDbMovie.swift
//  Movs
//
//  Created by Lucas Ferraço on 16/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

struct TMDbMovie: Codable {
	let id: Int?
	let voteCount: Int?
	let video: Bool?
	let voteAverage: Double?
	let title: String?
	let popularity: Double?
	let posterPath: String?
	let originalLanguage: String?
	let originalTitle: String?
	let genreIds: [Int]?
	var genreNames: [String]?
	let backdropPath: String?
	let adult: Bool?
	let overview: String?
	let releaseDate: String?
	
	enum CodingKeys: String, CodingKey {
		case voteCount = "vote_count"
		case id, video
		case voteAverage = "vote_average"
		case title, popularity
		case posterPath = "poster_path"
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case genreIds = "genre_ids"
		case genreNames = "genres"
		case backdropPath = "backdrop_path"
		case adult, overview
		case releaseDate = "release_date"
	}
}
