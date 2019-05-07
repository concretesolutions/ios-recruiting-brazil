//
//  FavoriteMovie+CoreDataProperties.swift
//  Movs
//
//  Created by Ygor Nascimento on 07/05/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var overview: String?
    @NSManaged public var poster: NSObject?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?

}
