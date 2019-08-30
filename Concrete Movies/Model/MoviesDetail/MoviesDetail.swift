//
//  MoviesDetail.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 25/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation

class MoviesDetail : Codable {
    let adult                 : Bool?
    let backdrop_path         : String?
    let belongs_to_collection : String?
    let budget                : Int?
    let genres                : [Genres]?
    let homepage              : String?
    let id                    : Int?
    let imdb_id               : String?
    let original_language     : String?
    let original_title        : String?
    let overview              : String?
    let popularity            : Double?
    let poster_path           : String?
    let productionCompanies  : [ProductionCompanies]?
    let productionCountries  : [ProductionCountries]?
    let release_date          : String?
    let revenue               : Int?
    let runtime               : Int?
    let spoken_languages      : [Spoken_languages]?
    let status                : String?
    let tagline               : String?
    let title                 : String?
    let video                 : Bool?
    let vote_average          : Double?
    let vote_count            : Int?
    
    /*enum CodingKeys: String, CodingKey {
        case adult                 = "adult"
        case backdrop_path         = "backdrop_path"
        case belongs_to_collection = "belongs_to_collection"
        case budget                = "budget"
        case genres                = "genres"
        case homepage              = "homepage"
        case id                    = "id"
        case imdb_id               = "imdb_id"
        case original_language     = "original_language"
        case original_title        = "original_title"
        case overview              = "overview"
        case popularity            = "popularity"
        case poster_path           = "poster_path"
        case production_companies  = "productionCompanies"
        case production_countries  = "productionCountries"
        case release_date          = "release_date"
        case revenue               = "revenue"
        case runtime               = "runtime"
        case spoken_languages      = "spoken_languages"
        case status                = "status"
        case tagline               = "tagline"
        case title                 = "title"
        case video                 = "video"
        case vote_average          = "vote_average"
        case vote_count            = "vote_count"
    }*/
    
    /*init(from decoder: Decoder) throws {
        let values            = try decoder.container(keyedBy: CodingKeys.self)
        adult                 = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdrop_path         = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        belongs_to_collection = try values.decodeIfPresent(String.self, forKey: .belongs_to_collection)
        budget                = try values.decodeIfPresent(Int.self, forKey: .budget)
        genres                = try values.decodeIfPresent([Genres].self, forKey: .genres)
        homepage              = try values.decodeIfPresent(String.self, forKey: .homepage)
        id                    = try values.decodeIfPresent(Int.self, forKey: .id)
        imdb_id               = try values.decodeIfPresent(String.self, forKey: .imdb_id)
        original_language     = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_title        = try values.decodeIfPresent(String.self, forKey: .original_title)
        overview              = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity            = try values.decodeIfPresent(Double.self, forKey: .popularity)
        poster_path           = try values.decodeIfPresent(String.self, forKey: .poster_path)
        productionCompanies  = try values.decodeIfPresent([ProductionCompanies].self, forKey: .production_companies)
        productionCountries  = try values.decodeIfPresent([ProductionCountries].self, forKey: .production_countries)
        release_date          = try values.decodeIfPresent(String.self, forKey: .release_date)
        revenue               = try values.decodeIfPresent(Int.self, forKey: .revenue)
        runtime               = try values.decodeIfPresent(Int.self, forKey: .runtime)
        spoken_languages      = try values.decodeIfPresent([Spoken_languages].self, forKey: .spoken_languages)
        status                = try values.decodeIfPresent(String.self, forKey: .status)
        tagline               = try values.decodeIfPresent(String.self, forKey: .tagline)
        title                 = try values.decodeIfPresent(String.self, forKey: .title)
        video                 = try values.decodeIfPresent(Bool.self, forKey: .video)
        vote_average          = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count            = try values.decodeIfPresent(Int.self, forKey: .vote_count)
    }*/
    
}
