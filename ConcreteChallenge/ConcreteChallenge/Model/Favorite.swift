//
//  Favorite.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import CoreData
import Foundation
import RxSwift

class Favorite: PersistableModelDelegate, Codable {
    var entityName: String = "FavoriteData"
    
    let title: String
    var id: Int
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    var genres: [String]?
    let originalTitle: String
    let originalLanguage: String
    let backdropPath: String?
    let video: Bool
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    
    static func getAll() -> [Favorite] {
        return []
    }
    
    func getDictionary() throws -> [String : Any]? {
        return [
            "id": Int64(self.id),
            "title": self.title,
            "posterPath": self.posterPath ?? "",
            "adult": self.adult,
            "overview": self.overview,
            "releaseDate": self.releaseDate,
            "originalTitle": self.originalTitle,
            "originalLanguage": self.originalLanguage,
            "backdropPath": self.backdropPath ?? "",
            "video": self.video,
            "popularity": self.popularity,
            "voteCount": Int64(self.voteCount),
            "voteAverage": self.voteAverage,
            "genreIds": self.genreIds,
            "genres": self.genres ?? []
        ]
    }
    
    func remove() {
        mainStore.dispatch(FavoriteThunk.remove(id: self.id))
    }
    
    init(with movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.adult = movie.adult
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.originalTitle = movie.originalTitle
        self.originalLanguage = movie.originalLanguage
        self.backdropPath = movie.backdropPath
        self.video = movie.video
        self.popularity = movie.popularity
        self.voteCount = movie.voteCount
        self.voteAverage = movie.voteAverage
        self.genreIds = movie.genreIds
        self.genres = movie.genres
    }
    
    init(_ managedObject: NSManagedObject) {
        id = managedObject.value(forKey: "id") as! Int
        title = managedObject.value(forKey: "title") as! String
        posterPath = managedObject.value(forKey: "posterPath") as! String?
        adult = managedObject.value(forKey: "adult") as! Bool
        overview = managedObject.value(forKey: "overview") as! String
        releaseDate = managedObject.value(forKey: "releaseDate") as! String
        genreIds = managedObject.value(forKey: "genreIds") as! [Int]
        genres = managedObject.value(forKey: "genres") as! [String]?
        originalTitle = managedObject.value(forKey: "originalTitle") as! String
        originalLanguage = managedObject.value(forKey: "originalLanguage") as! String
        backdropPath = managedObject.value(forKey: "backdropPath") as! String?
        video = managedObject.value(forKey: "video") as! Bool
        popularity = managedObject.value(forKey: "popularity") as! Double
        voteCount = managedObject.value(forKey: "voteCount") as! Int
        voteAverage = managedObject.value(forKey: "voteAverage") as! Double
    }
}

extension Favorite: Equatable {
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}
