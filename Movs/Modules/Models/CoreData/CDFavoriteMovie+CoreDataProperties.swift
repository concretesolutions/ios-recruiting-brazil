//
//  CDFavoriteMovie+CoreDataProperties.swift
//  Movs
//
//  Created by Gabriel D'Luca on 07/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//
//

import Foundation
import CoreData

extension CDFavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoriteMovie> {
        return NSFetchRequest<CDFavoriteMovie>(entityName: "CDFavoriteMovie")
    }

    @NSManaged public var movieID: Int64

}
