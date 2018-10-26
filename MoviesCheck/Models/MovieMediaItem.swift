//
//  MovieMediaItem.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

struct MovieMediaItem:Codable {
    
    var id:Int
    var evaluation:Float
    var title:String
    var poster:String?
    var overview:String
    var releaseDate:String
    
    enum CodingKeys : String, CodingKey {
        case id
        case evaluation = "vote_average"
        case title = "title"
        case poster = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    
    func getPosterURL()->String{
        
        if let posterFile = poster{
            return "URL POSTER"
        }else{
            return "noposter"
        }
        
    }
    
    func getYear()->String{
        return "ANO aqui"
    }
    
    func getDateDescription()->String{
        return "Data aqui"
    }
    
}
