//
//  CDGenre+CoreDataProperties.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//
//

import Foundation
import CoreData


extension CDGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGenre> {
        return NSFetchRequest<CDGenre>(entityName: "CDGenre")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}
