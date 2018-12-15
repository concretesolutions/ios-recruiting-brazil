//
//  PopularResults.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

struct Popular: Codable {
    
    //MARK: - PROPERTIES
    
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [PopularResults]
    
    //MARK: - INITIALIZERS
    
    init(page: Int, total_results: Int, total_pages: Int, results: [PopularResults]) {
        self.page = page
        self.total_results = total_results
        self.total_pages = total_pages
        self.results = results
    }
}

struct PopularResults: Codable {
    let poster_path: String?
    let adult: Bool
    let overview: String
    let release_date: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String?
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let vote_average: Double
}

struct PopularMovie {
    
}

struct PopularMovieDetailed {
    let posterPath: String?
    var overview: String
    var releaseDate: String
    var genreIDs: (([Int]) -> String)
    var id: Int
    var originalTitle: String
    var title: String
    
    init(posterPath: String?, overview: String, releaseDate: String, genreIDs: @escaping (([Int]) -> String), id: Int, originalTitle: String, title: String) {
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIDs = genreIDs
        self.id = id
        self.originalTitle = originalTitle
        self.title = title
    }
}
