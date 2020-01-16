//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Marcos Santos on 19/12/19.
//
//

import Foundation
import CoreData
import UIKit

@objc(Movie)
public class Movie: NSManagedObject, Decodable {

    public var image: UIImage = .placeholder

    enum CodingKeys: String, CodingKey {
        case id
        case imagePath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
        case genres = "genres"
    }

    // MARK: Codable

    required convenience public init(from decoder: Decoder) throws {
        try self.init(saving: false)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int64.self, forKey: .id)
        imagePath = try container.decode(String.self, forKey: .imagePath)
        overview = try container.decode(String.self, forKey: .overview)
        title = try container.decode(String.self, forKey: .title)

        releaseDate = try decoder.decode(CodingKeys.releaseDate, using: DateFormatter.databaseDate)

        if let genres = try container.decodeIfPresent([Genre].self, forKey: .genres) {
            for genre in genres {
                addToGenres(genre)
                genre.addToMovies(self)
            }
        }
    }

    func isSaved() throws -> Bool {
        return (try Self.queryById(Int(id))) != nil
    }

    func insertIntoContext() throws {
        if !isInserted {
            let context = try CoreDataManager.getContext()
            context.insert(self)

            for genre in (genres?.allObjects as? [Genre]) ?? [] {
                try genre.insertIntoContext()
            }
        }
    }

    @discardableResult
    func deepCopy(saving: Bool = true) throws -> Movie {
        let movie = try Movie(saving: saving)

        movie.id = id
        movie.imagePath = imagePath
        movie.overview = overview
        movie.releaseDate = releaseDate
        movie.title = title

        for genre in (genres?.allObjects as? [Genre]) ?? [] {
            movie.addToGenres(try genre.deepCopy(saving: saving))
        }

        return movie
    }
}
