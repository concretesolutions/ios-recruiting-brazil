//
//  Movies.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation
import RealmSwift

struct Movie {
    var id: Int
    var posterPath: String
    var adult: Bool
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var voteAvarage: Double
    var favorited: Bool

}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case title
        case popularity
        case video
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAvarage = "vote_average"
        case favorited
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let pathPosterImage: String? = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let posterPath: String = pathPosterImage != nil ? Constants.baseImageUrl + Constants.posterSize + pathPosterImage! : ""
        let pathBackdropImage: String? = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        let backdropPath: String = pathBackdropImage != nil ? Constants.baseImageUrl + Constants.backdropSize + pathBackdropImage! : ""
        let adult: Bool = try container.decode(Bool.self, forKey: .adult)
        let video: Bool = try container.decode(Bool.self, forKey: .video)
        let overview: String = try container.decode(String.self, forKey: .overview)
        let title: String = try container.decode(String.self, forKey: .title)
        let originalTitle: String = try container.decode(String.self, forKey: .originalTitle)
        let originalLanguage: String = try container.decode(String.self, forKey: .originalLanguage)
        let genreIds: [Int] = try container.decode([Int].self, forKey: .genreIds)
        let popularity: Double = try container.decode(Double.self, forKey: .popularity)
        let voteAvarage: Double = try container.decode(Double.self, forKey: .voteAvarage)
        let voteCount: Int = try container.decode(Int.self, forKey: .voteCount)
        let releaseDate: String = try container.decode(String.self, forKey: .releaseDate)
        
        self.init(id: id, posterPath: posterPath, adult: adult, overview: overview, releaseDate: releaseDate, genreIds: genreIds, originalTitle: originalTitle, originalLanguage: originalLanguage, title: title, backdropPath: backdropPath, popularity: popularity, voteCount: voteCount, video: video, voteAvarage: voteAvarage, favorited: false)
    }
}

final class MoviesObject: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var posterPath: String = ""
    @objc dynamic var adult: Bool = false
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String = ""
    var genreIds: List<Int> = List<Int>()
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAvarage: Double = 0.0
    @objc dynamic var favorited: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Movie: Persistable {
    typealias ManagedObject = MoviesObject
    
    public init(managedObject: ManagedObject) {
        id = managedObject.id
        posterPath = managedObject.posterPath
        adult = managedObject.adult
        overview = managedObject.overview
        releaseDate = managedObject.releaseDate
        genreIds = Array(managedObject.genreIds)
        originalTitle = managedObject.originalTitle
        originalLanguage = managedObject.originalLanguage
        title = managedObject.title
        backdropPath = managedObject.backdropPath
        popularity = managedObject.popularity
        voteCount = managedObject.voteCount
        video = managedObject.video
        voteAvarage = managedObject.voteAvarage
        favorited = managedObject.favorited
    }
    
    public func managedObject() -> Movie.ManagedObject {
        let movie = MoviesObject()
        movie.id = id
        movie.posterPath = posterPath
        movie.adult = adult
        movie.overview = overview
        movie.releaseDate = releaseDate
        movie.genreIds.append(objectsIn: genreIds)
        movie.originalTitle = originalTitle
        movie.originalLanguage = originalLanguage
        movie.title = title
        movie.backdropPath = backdropPath
        movie.popularity = popularity
        movie.voteCount = voteCount
        movie.video = video
        movie.voteAvarage = voteAvarage
        movie.favorited = favorited
        
        return movie
    }
}
