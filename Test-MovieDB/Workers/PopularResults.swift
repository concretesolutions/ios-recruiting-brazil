//
//  PopularResults.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

struct Popular: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [PopularResults]
    
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
