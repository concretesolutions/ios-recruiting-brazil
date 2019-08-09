//
//  MovieDetailsData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct MovieDetailsData {
    var id:Int
    var name:String
    var description:String
    var imageUrl:String
    
    init(id:Int, name:String, description:String, imageUrl:String) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
}

extension MovieDetailsData : Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case description = "overview"
        case imageUrl = "poster_path"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeDecodable = try container.decode(Int.self, forKey: .id)
        let nameDecodable = try container.decode(String.self, forKey: .name)
        let descriptionDecodable = try container.decode(String.self, forKey: .description)
        let imageUrlDecodable = try container.decode(String.self, forKey: .imageUrl)
        self.init(id: codeDecodable, name: nameDecodable, description: descriptionDecodable, imageUrl:imageUrlDecodable)
    }
}
