//
//  UrlEnum.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import Foundation
enum EndPoints:String{
    case baseUrl = "https://api.themoviedb.org/3/"
    case moviePopular = "movie/popular"
    case movieDetails = "movie"
    case apiKey = "?api_key=fb36a114c1dd651ad2d0d45ebbabad10"
    case baseImageUrl = "https://image.tmdb.org/t/p/w400"
}
