//
//  GenresResult.swift
//  Movs
//
//  Created by Tiago Chaves on 14/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

struct GenresResult:Codable {
	
	let genres:[GenreData]
}

struct GenreData:Codable{
	
	let id:Int
	let name:String
	
	static func getGenreData(ofGenres genres:[Genre]) -> [GenreData] {
		
		var genresData:[GenreData] = []
		
		for genre in genres {
			
			let genreData:GenreData = GenreData(id: Int(genre.id), name: genre.name ?? "-")
			
			genresData.append(genreData)
		}
		
		return genresData
	}
}
