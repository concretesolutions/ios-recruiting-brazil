//
//  FavoriteMovie+CoreDataProperties.swift
//  
//
//  Created by Kaique Damato on 15/1/20.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: String?
    @NSManaged public var overview: String?

}
