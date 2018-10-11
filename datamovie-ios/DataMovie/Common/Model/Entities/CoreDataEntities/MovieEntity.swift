//
//  MovieEntity+CoreDataClass.swift
//  DataMovie
//
//  Created by Andre Souza on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

enum MovieListFilter {
    
    case onlyFavorites
    case onlyWatched(watched: Bool)
    
    var predicate: NSPredicate {
        switch self {
        case .onlyFavorites:
            return NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        case .onlyWatched(let watched):
            return NSPredicate(format: "didWatch == %@", NSNumber(value: watched))
        }
    }
    
}

@objc(MovieEntity)
public class MovieEntity: NSManagedObject, FetchableProtocol {
    
    @NSManaged public var budget: String?
    @NSManaged public var homepage: String?
    @NSManaged public var imdbID: String?
    @NSManaged public var isAdult: Bool
    @NSManaged public var isFavorite: Bool
    @NSManaged public var didWatch: Bool
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var revenue: String?
    @NSManaged public var runtime: String?
    @NSManaged public var status: String?
    @NSManaged public var title: String?
    @NSManaged public var tmdbID: Int32
    @NSManaged public var voteAverage: String?
    @NSManaged public var personalRating: Float
    @NSManaged public var genres: Set<GenreEntity>
    @NSManaged public var cast: Set<CastEntity>
    @NSManaged public var crew: Set<CrewEntity>
    @NSManaged public var videos: Set<VideoEntity>
    
}

// MARK: Generated accessors for genres

extension MovieEntity {
    
    @objc(addGenreObject:)
    @NSManaged public func addToGenres(_ value: GenreEntity)
    
    @objc(removeGenreObject:)
    @NSManaged public func removeFromGenres(_ value: GenreEntity)
    
    @objc(addGenre:)
    @NSManaged public func addToGenres(_ values: Set<GenreEntity>)
    
    @objc(removeGenre:)
    @NSManaged public func removeFromGenres(_ values: Set<GenreEntity>)
    
}

// MARK: Generated accessors for cast

extension MovieEntity {
    
    @objc(addCastObject:)
    @NSManaged public func addToCast(_ value: CastEntity)
    
    @objc(removeCastObject:)
    @NSManaged public func removeFromCast(_ value: CastEntity)
    
    @objc(addCast:)
    @NSManaged public func addToCast(_ values: Set<CastEntity>)
    
    @objc(removeCast:)
    @NSManaged public func removeFromCast(_ values: Set<CastEntity>)
    
}

// MARK: Generated accessors for crew

extension MovieEntity {
    
    @objc(addCrewObject:)
    @NSManaged public func addToCast(_ value: CrewEntity)
    
    @objc(removeCrewObject:)
    @NSManaged public func removeFromCast(_ value: CrewEntity)
    
    @objc(addCrew:)
    @NSManaged public func addToCast(_ values: Set<CrewEntity>)
    
    @objc(removeCrew:)
    @NSManaged public func removeFromCast(_ values: Set<CrewEntity>)
    
}

// MARK: Generated accessors for videos

extension MovieEntity {
    
    @objc(addVideosObject:)
    @NSManaged public func addToVideos(_ value: VideoEntity)
    
    @objc(removeVideosObject:)
    @NSManaged public func removeFromVideos(_ value: VideoEntity)
    
    @objc(addVideos:)
    @NSManaged public func addToVideos(_ values: Set<VideoEntity>)
    
    @objc(removeVideos:)
    @NSManaged public func removeFromVideos(_ values: Set<VideoEntity>)
    
}

// MARK: - Custom init -

extension MovieEntity {
    
    convenience init(with model: MovieModel) {
        self.init()
        
        if let tmdbID = model.tmdbID {
            self.tmdbID = Int32(tmdbID)
        }
        
        self.imdbID = model.imdbID
        self.title = model.title
        self.originalTitle = model.originalTitle
        self.overview = model.overview
        self.posterPath = model.posterPath
        
        if let spokenLanguage = model.spokenLanguage,
            let originalLanguage = model.originalLanguage,
            let language = spokenLanguage.filter({ $0.iso_639_1 == originalLanguage }).compactMap({ $0.name }).first {
            self.originalLanguage = language
        }
        
        if let budget = model.budget {
            self.budget = budget.decimalFormat()
        } else {
            self.budget = nil
        }
        
        if let revenue = model.revenue {
            self.revenue = revenue.decimalFormat()
        } else {
            self.revenue = nil
        }
        
        self.homepage = model.homepage
        self.isAdult = model.isAdult ?? false
        
        if let releaseDate = model.releaseDate, !releaseDate.isEmpty,
            let date = Date(dateString: releaseDate) {
            self.releaseDate = date.stringFormat()
        } else {
            self.releaseDate = nil
        }
        
        if let runtime = model.runtime {
            let (hour, minute) = Util.secondsToHoursMinutesSeconds(seconds: runtime)
            self.runtime = "\(hour)h \(minute)m"
        } else {
            self.runtime = nil
        }
        
        if let voteAverage = model.voteAverage {
            self.voteAverage = "\(voteAverage)"
        } else {
            self.voteAverage = nil
        }
        
        self.status = model.status
        
        if let genres = model.genres {
            genres.filter({ $0.genreID != nil && $0.name != nil}).forEach() { genre in
                if let alreadyGenre = GenreEntity.findWhere(.isEqual(attributeName: "name", value: genre.name!))?.first {
                    self.genres.insert(alreadyGenre)
                } else {
                    let genreEntity = GenreEntity()
                    genreEntity.genreID = Int32(genre.genreID!)
                    genreEntity.name = genre.name!
                    self.genres.insert(genreEntity)
                }
            }
        }
        
        if let cast = model.credits?.cast {
            cast.filter({ $0.name != nil && $0.personID != nil }).forEach() { castModel in
                if let alreadyCast = CastEntity.findWhere(.isEqual(attributeName: "personID", value: "\(castModel.personID!)"))?.first {
                    self.cast.insert(alreadyCast)
                } else if let cast = CastEntity(with: castModel) {
                    self.cast.insert(cast)
                }
            }
        }
        
        if let videos = model.videos {
            videos.forEach() { video in
                if let videoEntity = VideoEntity(with: video) {
                    self.videos.insert(videoEntity)
                }
            }
        }
        
        self.didWatch = false
        self.isFavorite = false
        self.personalRating = 0
        
    }

    convenience private init() {
        self.init(context: CoreDataStack.sharedInstance.persistentContainer.viewContext)
    }
    
}

// MARK: Some extensions

extension MovieEntity {
    
    var genresSorted: [String] {
        get {
            return genres.sorted(by: { $0.name < $1.name }).compactMap({ $0.name })
        }
    }
    
    var castSorted: [CastEntity] {
        get {
            return cast.sorted(by: { $0.order < $1.order })
        }
    }
    
    var videosSorted: [VideoEntity] {
        return videos.sorted(by: { $0.name < $1.name })
    }
    
}

// MARK: - Protocol MovieListItem -

protocol MovieListItem {
    var title: String? { get }
    var poster: UIImage { get }
}

extension MovieEntity: MovieListItem {
    
    var poster: UIImage {
        guard
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
            let posterPath = self.posterPath,
            let image = UIImage(contentsOfFile: fileURL.appendingPathComponent(posterPath).path)
        else {
            return #imageLiteral(resourceName: "ic_place_holder")
        }
        return image
    }
    
}

// MARK: - Protocol MovieViewDetail -

protocol MovieViewDetail: MovieListItem {
    var budget: String? { get }
    var homepage: String? { get }
    var isFavorite: Bool { get }
    var didWatch: Bool { get }
    var originalLanguage: String? { get }
    var originalTitle: String? { get }
    var overview: String? { get }
    var releaseDate: String? { get }
    var revenue: String? { get }
    var runtime: String? { get }
    var status: String? { get }
    var voteAverage: String? { get }
    var personalRating: Float { get }
    var posterPath: String? { get }
}

extension MovieEntity: MovieViewDetail { }

//Custom filter

extension MovieEntity {
    
    static func fetchAllFiltering(movieListFilter: [MovieListFilter], offSet: Int? = nil, limit: Int? = nil) -> [MovieEntity]? {
        let fetchRequest = NSFetchRequest<FetchableType>(entityName: identifier)
        
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        
        if let offSet = offSet {
            fetchRequest.fetchOffset = offSet
        }

        if movieListFilter.count > 0 {
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: movieListFilter.map({ $0.predicate }))
            fetchRequest.predicate = andPredicate
        }
        
        do {
            let objct = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest) as [MovieEntity]
            return objct
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
        
        return nil
    }
    
}



