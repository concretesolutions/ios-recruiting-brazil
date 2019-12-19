//
//  Helpers.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 12/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation

func formateYear(date:String?) -> String{
    if let date = date {
        let parts:[String] = date.components(separatedBy: "-")
           return parts[0]
    }
    else {
        return ""
    }
   
}
func getFavoritesMovies() -> [Movie]{
    let coreDataFavoritesMovies = fetch()
    var movies:[Movie] = []
    for coreData in coreDataFavoritesMovies{
        if let title = coreData.value(forKey: "title") as? String{
            if let genreIDS = coreData.value(forKey: "genreIDS") as? [Int]{
                if let overview = coreData.value(forKey: "overview") as? String{
                    if let backdropPath = coreData.value(forKey: "backdropPath") as? String{
                        if let id = coreData.value(forKey: "id") as? Int{
                            if let releaseDate = coreData.value(forKey: "releaseDate") as? String{
                                movies.append(Movie(id: id, backdropPath: backdropPath, genreIDS: genreIDS, title: title, overview: overview, releaseDate: releaseDate))
                            }
                        }
                    }
                }
            }
        }
    }
    
    return movies
}
func formatGenres(list:[Int]?) -> String{
    var value = ""
    guard let list = list else{
        return value
    }
    for id in list{
        for genre in ManegerApiRequest.genres{
            if genre.id == id{
                value.append(genre.name)
                value.append(",")
            }
        }
    }
    if value != ""{
        value.removeLast()
    }
    return value
}
