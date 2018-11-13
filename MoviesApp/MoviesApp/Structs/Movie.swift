//
//  Movie.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation
import UIKit


struct Response: DataObject {
    var results: [Movie]
    var page: Int
    var total_results: Int
    var dates: Dates
    var total_pages: Int
}

struct Dates: DataObject {
    var maximum: String
    var minimum: String
}

struct Movie: DataObject{
    var vote_count: Int
    var id: Double
    var video: Bool
    var vote_average: Float
    var popularity: Double
    var title: String
    //var imageUrl: String
    var release_date: String
    var overview: String
    
}


struct Results: DataObject {
    var movies: [Movie]
}

