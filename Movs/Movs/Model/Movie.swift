//
//  File.swift
//  Movs
//
//  Created by Erick Lozano Borges on 11/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import RealmSwift

struct Movie {
    
    var id: Int
    var title: String
    var genres: [Genre]
    var overview: String
    var thumbFilePath: String
    
    public init(id: Int, title: String, genres: [Genre], overview: String, thumbFilePath: String) {
        self.id = id
        self.title = title
        self.genres = genres
        self.overview = overview
        self.thumbFilePath = thumbFilePath
    }
    
    public init(_ movieRlm: MovieRlm) {
        id = movieRlm.id
        title = movieRlm.title
        genres = movieRlm.genres.map({ return Genre($0) })
        overview = movieRlm.overview
        thumbFilePath = movieRlm.thumbFilePath
    }
    
    func rlm() -> MovieRlm {
        return MovieRlm.build { (objectRlm) in
            objectRlm.id = self.id
            objectRlm.title = self.title
            genres.forEach({ objectRlm.genres.append($0.rlm()) })
            objectRlm.overview = self.overview
            objectRlm.thumbFilePath = self.thumbFilePath
        }        
    }
    
}

extension Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genres = "genre_ids"
        case overview
        case thumbFilePath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        thumbFilePath = try container.decode(String.self, forKey: .thumbFilePath)
        
        genres = [Genre]()
        let ids = try container.decode([Int].self, forKey: .genres)
        ids.forEach({ self.genres.append(Genre(id:$0)) })
    }
    
}
