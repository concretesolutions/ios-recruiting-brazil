//
//  FavoriteMovie+CoreDataProperties.swift
//  Movs
//
//  Created by Tiago Chaves on 15/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func favoriteMovieFetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var backdropUrl: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var overview: String?
    @NSManaged public var posterUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var genre_ids: NSObject?

}
