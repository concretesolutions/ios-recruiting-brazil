//
//  FavoriteMovies+CoreDataProperties.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovies> {
        return NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
    }

    @NSManaged public var title: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var genreID: [Int]?
    @NSManaged public var yearOfRelease: String?
    @NSManaged public var id: Int64

}
