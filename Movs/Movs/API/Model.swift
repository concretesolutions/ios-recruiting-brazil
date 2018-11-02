//
//  Model.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    
    let id:Int
    let title:String
    let posterPath:String
    var isFavorite:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

public struct MovieDetail: Codable {
    
    let id:Int
    let title:String
    let posterPath:String
    let genres:[String]
    let overview:String
    var isFavorite:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case genres
        case overview
    }
}
