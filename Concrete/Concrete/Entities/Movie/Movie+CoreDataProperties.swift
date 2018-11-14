//
//  Movie+CoreDataProperties.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 14/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var id: Int32
    @NSManaged public var popularity: Double
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var voteAvarage: Double
    @NSManaged public var genresIds: NSObject?

}
