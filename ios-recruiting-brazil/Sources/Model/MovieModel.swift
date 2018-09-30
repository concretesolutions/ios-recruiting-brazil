//
//  MovieModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper

struct MovieModel: Mappable {
    var id: Int
    var posterPath: String
    var title: String
    var desc: String
    var releaseDate: String
    var releaseYear: String
    var genders: [GenderModel]
    var isFavorite: Bool = false
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try posterPath = map.from("poster_path")
        try title = map.from("original_title")
        try desc = map.from("overview")
        try releaseDate = map.from("release_date")
        releaseYear = String(releaseDate.split(separator: "-")[0])
        let genderIds: [Int] = try map.from("genre_ids")
        genders = genderIds.map({ return GenderModel(id: $0)})
    }
    
    public init(id: Int,
                posterPath: String,
                title: String,
                desc: String,
                releaseDate: String,
                releaseYear: String,
                genders: [GenderModel],
                isFavorite: Bool) {
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.desc = desc
        self.releaseDate = releaseDate
        self.releaseYear = releaseYear
        self.genders = genders
        self.isFavorite = isFavorite
    }
    
    public init(RLMMovieModel: RLMMovieModel) {
        self.init(id: RLMMovieModel.id,
                  posterPath: RLMMovieModel.posterPath,
                  title: RLMMovieModel.title,
                  desc: RLMMovieModel.desc,
                  releaseDate: RLMMovieModel.releaseDate,
                  releaseYear: RLMMovieModel.releaseYear,
                  genders: RLMMovieModel.genders.map({ GenderModel(RLMGenderModel: $0) }),
                  isFavorite: RLMMovieModel.isFavorite)
    }
    
    func asRealm() -> RLMMovieModel {
        return RLMMovieModel.build({ object in
            object.id = self.id
            object.posterPath = self.posterPath
            object.title = self.title
            object.desc = self.desc
            object.releaseDate = self.releaseDate
            object.releaseYear = self.releaseYear
            self.genders.forEach({ object.genders.append($0.asRealm()) })
            object.isFavorite = self.isFavorite
        })
    }
}
