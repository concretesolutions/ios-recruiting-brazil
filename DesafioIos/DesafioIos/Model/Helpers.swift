////
////  Helpers.swift
////  DesafioIos
////
////  Created by Kacio Henrique Couto Batista on 12/12/19.
////  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
////
//
//import Foundation
//
//func formateYear(date:String) -> String{
//    let parts:[String] = date.components(separatedBy: "-")
//    return parts[0]
//}
//func takePopularMovies(movies:inout [Movie]) {
//    let url = "https://api.themoviedb.org/3/movie/popular"
//    movies = []
//    for i in 1...6{
//        let query:[String:Any] =  ["api_key":apiKey,
//        "page":"\(i)",
//        "language":"en-US",
//        "region":"US"]
//        getRequest(url: url, query: queryGenre) { (catolg) in
//            movies.append(contentsOf: catolg.results)
//        }
//    }
//}
//func formatGenres(list:[Int]) -> String{
//    var value = ""
//    for id in list{
//        for genre in genres{
//            if genre.id == id{
//                value.append(genre.name)
//                value.append(",")
//            }
//        }
//    }
//    value.removeLast()
//    return value
//}
