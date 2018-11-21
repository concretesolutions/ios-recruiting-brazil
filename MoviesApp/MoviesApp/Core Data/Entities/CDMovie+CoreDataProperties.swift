//
//  CDMovie+CoreDataProperties.swift
//  
//
//  Created by Nicholas Babo on 13/11/18.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: PersistedEntity.movie)
    }

    @NSManaged public var id: Int32
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Float
    @NSManaged public var overview: String?

}
