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
//    var genderIds: [Int]
    var isFavourite: Bool
    var overview: String
    var thumbFilePath: String
    
    public init(id: Int, title: String, genres: [Genre], isFavourite: Bool, overview: String, thumbFilePath: String) {
        self.id = id
        self.title = title
        self.genres = genres
        self.isFavourite = isFavourite
        self.overview = overview
        self.thumbFilePath = thumbFilePath
    }
    
    public init(_ movieRlm: MovieRlm) {
        id = movieRlm.id
        title = movieRlm.title
        genres = movieRlm.genres.map({ return Genre($0)})
        isFavourite = movieRlm.isFavourite
        overview = movieRlm.overview
        thumbFilePath = movieRlm.thumbFilePath
    }
    
    func rlm() -> MovieRlm {
        return MovieRlm.build { (objectRlm) in
            objectRlm.id = self.id
            objectRlm.title = self.title
            genres.forEach({ objectRlm.genres.append($0.rlm()) })
            objectRlm.isFavourite = self.isFavourite
            objectRlm.overview = self.overview
            objectRlm.thumbFilePath = self.thumbFilePath
        }        
    }
}
