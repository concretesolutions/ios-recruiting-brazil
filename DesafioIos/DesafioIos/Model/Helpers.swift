//
//  Helpers.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 12/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
var queryMoviesPopular:[String:Any] =  ["api_key":apiKey,
                                        "page":"1",
                                        "language":"en-US",
                                        "region":"US"]
var apiKey = "21f18125f6767ae14a2f2577d85de3db"
var queryGenre = ["api_key":apiKey,
                  "language":"en-US"]

var genres:[Genre] = [] {
    didSet{
        print("load genre")
    }
}
func formateYear(date:String) -> String{
    let parts:[String] = date.components(separatedBy: "-")
    return parts[0]
}
func takePopularMovies() {
    let url = "https://api.themoviedb.org/3/movie/popular"
    var movies:Movies
    getRequest(url: url, data: <#T##[String : Any]#>, completion: <#T##(Movies) -> Void#>)
}
func formatGenres(list:[Int]) -> String{
    var value = ""
    for id in list{
        for genre in genres{
            if genre.id == id{
                value.append(genre.name)
                value.append(",")
            }
        }
    }
    value.removeLast()
    return value
}
