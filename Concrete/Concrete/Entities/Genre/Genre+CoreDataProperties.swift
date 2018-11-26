//
//  Genre+CoreDataProperties.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 14/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}
