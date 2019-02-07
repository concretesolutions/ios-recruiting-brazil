//
//  CDMovie+CoreDataProperties.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var id: Int32
    @NSManaged public var overview: String?
    @NSManaged public var genres: [String]?

}
