//
//  DAO.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 23/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation
import UIKit

let dao = DAO()
class DAO:Codable{
    var page = 1
    var cellWidth:CGFloat = 0
    let apiKey = "0c909c364c0bc846b72d0fe49ab71b83"
//    let fakeSearchURL = "https://api.themoviedb.org/3/search/movie?api_key=0c909c364c0bc846b72d0fe49ab71b83&query=Frozen"
    let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=0c909c364c0bc846b72d0fe49ab71b83&language=en-US&page=1"
    var searchURL = "https://api.themoviedb.org/3/search/movie?api_key=0c909c364c0bc846b72d0fe49ab71b83&query="
    
    var searchResults:[Movie] = []
    var favoriteMovies:[Movie] = []
}
