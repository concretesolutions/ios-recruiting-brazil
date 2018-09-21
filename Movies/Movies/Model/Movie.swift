//
//  Movie.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation

struct Genre:Codable{
    
    var id:Int?
    var name:String?

    private enum CodingKeys: String, CodingKey {
        case id    = "id"
        case name  = "name"
    }
}

struct Movie:Codable{

    var id:Int?
    var title:String?
    var genres:[Genre]?
    var overview:String?
    var releaseDate:String?
    var poster: String? {
        get{
            if let url = url{
                return "https://image.tmdb.org/t/p/w500/\(url)"
            }
            return nil
        }
    }
    
    private var url:String?
    private enum CodingKeys: String, CodingKey {
        case id          = "id"
        case title       = "original_title"
        case genres      = "genres"
        case overview    = "overview"
        case url         = "poster_path"
        case releaseDate = "release_date"
    }
    
    init(withId id:Int?=nil) {
        self.id = id
    }
    
    /// Converts the favorite list (Json String) to Array object
    static func convertJsonStringToFavoriteList(_ json:String?)->[Movie]{
        if let json = json, let data = json.data(using: .utf8, allowLossyConversion: false){
            if let list = try? JSONDecoder().decode([Movie].self, from: data){
                return list
            }
        }
        return []
    }
    
    /// Converts the favorite list (Object) to a Json String
    static func convertFavoriteListToJsonString(_ favorites:[Movie])->String?{
        guard let jsonData = try? JSONEncoder().encode(favorites) else{
            return nil
        }
        
        return String(data: jsonData, encoding: String.Encoding.utf8)
    }
}
