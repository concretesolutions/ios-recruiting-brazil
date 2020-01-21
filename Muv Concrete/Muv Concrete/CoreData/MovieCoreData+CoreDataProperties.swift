//
//  MovieCoreData+CoreDataProperties.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 21/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var genreIDs: [Int]
    @NSManaged public var posterPath: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var isFavorite: Bool

}
