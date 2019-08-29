//
//  Movies.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page, total_results, total_pages: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
   
    let id: Int32
    let title: String?
    let poster_path: String?
    let original_language: String?
    let genre_ids: [Int]?
    let overview: String?
    let release_date: String?
    var isFavorite: Bool? = false
    
    
    //MARK: Initializers
    public init(vote_count: Int, id: Int, title: String, video: Bool, vote_average: Double, popularity: Double, genres: [Int], overview: String, releaseYear: String, poster_path: String, original_language: String, original_title: String, backdrop_path: String, adult: Bool ) {
        
        self.id = Int32(id)
        self.title = title
        self.genre_ids = genres
        self.overview = overview
        self.release_date = releaseYear
        self.poster_path = poster_path
        self.original_language = original_language
        self.isFavorite = false
        
        }
    
    public init(_ movieCoreData: MovieEntity) {
        id = 1
        title = movieCoreData.movieTitle
        genre_ids = [0]
        overview = movieCoreData.movieDescription
        release_date = movieCoreData.movieDate
        poster_path = movieCoreData.movieImage
        original_language = "pt_BR"
        isFavorite = movieCoreData.movieIsFavorite
    }
    
    //MARK: - Mutating Methods
    mutating func setIsFavorite() {
        self.isFavorite = true
    }
}
