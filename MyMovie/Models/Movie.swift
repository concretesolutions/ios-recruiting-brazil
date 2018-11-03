//
//  Movie.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 21/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//
import UIKit

public struct Movie: Codable, PD_Type, Hashable {
	
	var movieID:Int
	var poster:String?
	var title:String?
	var descriptionMovie:String?
	var releaseDate:String?
	var genres: Array<Int>
	var favorite: Int
	public var hashValue: Int {
		return movieID.hashValue
	}
	
	public enum CodingKeys: String, CodingKey {
		case movieID = "id"
		case poster = "poster_path"
		case title = "title"
		case descriptionMovie = "overview"
		case releaseDate = "release_date"
		case genres =  "genre_ids"
		
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.movieID = try values.decode(Int.self, forKey: .movieID)
		self.poster = try values.decodeIfPresent(String.self, forKey: .poster)
		self.title = try values.decodeIfPresent(String.self, forKey: .title)
		self.descriptionMovie = try values.decodeIfPresent(String.self, forKey: .descriptionMovie)
		self.releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		self.genres = try values.decodeIfPresent(Array.self, forKey: .genres) ?? []
		self.favorite = 0
	}
	
	
	init(movieID: Int, poster: String, title: String, descriptionMovie: String, releaseDate: String, genres: Array<Int>, favorite: Int = 0) {
		
		self.movieID = movieID
		self.poster = poster
		self.title = title
		self.descriptionMovie = descriptionMovie
		self.releaseDate = releaseDate
		self.genres = genres
		self.favorite = favorite
	}
	
	public var formattedDescription: String {
		return self.title ?? "Sem titulo"
	}

}

