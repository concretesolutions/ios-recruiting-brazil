//
//  Helpers.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 12/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation

func formateYear(date:String) -> String{
    let parts:[String] = date.components(separatedBy: "-")
    return parts[0]
}
func getFavoritesMovies()->[Movie]{
    let coreDataFavoritesMovies = fetch()
    if coreDataFavoritesMovies == [] {
        return []
    }
    return coreDataFavoritesMovies.map { (coreData) -> Movie in
        return Movie(id: coreData.value(forKey: "id") as! Int, backdropPath: coreData.value(forKey: "backdropPath") as! String, genreIDS: coreData.value(forKey: "genreIDS") as! [Int], title: coreData.value(forKey: "title") as! String, overview: coreData.value(forKey: "overview") as! String , releaseDate: coreData.value(forKey: "releaseDate") as! String)
    }
}
func formatGenres(list:[Int]) -> String{
    var value = ""
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
