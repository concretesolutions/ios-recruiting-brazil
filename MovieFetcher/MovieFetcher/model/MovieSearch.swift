//
//  MovieSearch.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 23/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

class MovieSearch:Codable{
    let page:Int!
    let total_results:Int!
    let total_pages:Int!
    let results:[Movie]!
    
    init(page:Int,total_results:Int,total_pages:Int,results:[Movie]) {
        self.page = page
        self.total_results = total_results
        self.total_pages = total_pages
        self.results = results 
    }
    
    
    
}
