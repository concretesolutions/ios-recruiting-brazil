//
//  SearchWorker.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 14/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

struct SearchResultsWorker: Codable {
    
    //MARK: - PROPERTIES
    
    let page: Int
    let results: [ResultsOfSearchWorker]
    let total_pages: Int
    let total_results: Int
    
    //MARK: - INITIALIZERS
    
    init(page: Int, results: [ResultsOfSearchWorker], total_pages: Int, total_results: Int) {
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
}

struct ResultsOfSearchWorker: Codable {
    //let id: Int
    //let logo_path: String?
    //let name: String
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
