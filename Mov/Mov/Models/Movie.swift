//
//  Movie.swift
//  Mov
//
//  Created by Allan on 10/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie: Equatable{
    
    private let kPosterPath = "poster_path"
    private let kAdult = "adult"
    private let kOverview = "overview"
    private let kReleaseDate = "release_date"
    private let kGenreIds = "genre_ids"
    private let kGenres = "genres"
    private let kId = "id"
    private let kTitle = "title"
    private let kOriginalTitle = "original_title"
    private let kOriginalLanguage = "original_language"
    private let kBackdropPath = "backdrop_path"
    private let kPopularity = "popularity"
    private let kVoteCount = "vote_count"
    private let kVoteAverage = "vote_average"
    private let kVideo = "video"
    
    var posterPath: String?
    var isAdult: Bool = false
    var overview: String
    var releaseDate: Date
    var id: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Int
    var voteCount: Int
    var video: Bool
    var voteAverage: Float
    var genreIds = [Int]()
    
    //Calculated properties
    var genres = [String]()
    var imageURL: String?
    var isMyFavorite: Bool{
        return FavoriteController.shared.favorites.contains(self)
    }
    
    var genreList: String{
        return genres.compactMap({String($0)}).joined(separator: ", ")
    }
    
    var jsonValue: [String: Any]{
        var json: [String: Any] = [kAdult: isAdult,
                    kOverview: overview,
                    kReleaseDate: releaseDate.toString,
                    kId: id,
                    kOriginalTitle: originalTitle,
                    kOriginalLanguage: originalLanguage,
                    kTitle: title,
                    kPopularity: popularity,
                    kVoteCount: voteCount,
                    kVideo: video,
                    kVoteAverage: voteAverage,
                    kGenreIds: kGenreIds]
        
        if let posterPath = posterPath{
            json.updateValue(posterPath, forKey: kPosterPath)
        }
        
        if let backdropPath = backdropPath{
            json.updateValue(backdropPath, forKey: kBackdropPath)
        }
        
        return json
    }
    
    init?(with json: JSON) {
        guard let id = json[kId].int, let originalTitle = json[kOriginalTitle].string, let title = json[kTitle].string, let releaseDateStr = json[kReleaseDate].string else { return nil}
        
        self.id = id
        self.originalTitle = originalTitle
        self.title = title
        self.releaseDate = Date(with: releaseDateStr, andFormat: "YYYY-MM-dd") ?? Date()
        self.posterPath = json[kPosterPath].string
        self.isAdult = json[kAdult].boolValue
        self.overview = json[kOverview].stringValue
        self.originalLanguage = json[kOriginalLanguage].stringValue
        self.backdropPath = json[kBackdropPath].string
        self.popularity = json[kPopularity].intValue
        self.voteCount = json[kVoteCount].intValue
        self.video = json[kVideo].boolValue
        self.voteAverage = json[kVoteAverage].floatValue
        self.genreIds = json[kGenreIds].arrayObject as? [Int] ?? []
        
        if let posterPath = self.posterPath{
            self.imageURL = Constants.URL.imageURI + posterPath
        }
        
        if let genres = json[kGenres].array{
            for genre in genres{
                if let genreName = genre["name"].string{
                    self.genres.append(genreName)
                }
            }
        }
    }
    
    static func ==(rhs: Movie, lhs: Movie) -> Bool{
        return rhs.id == lhs.id
    }
}
