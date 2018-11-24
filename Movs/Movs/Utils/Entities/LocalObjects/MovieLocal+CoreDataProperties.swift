//
//  MovieLocal+CoreDataProperties.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 15/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieLocal> {
        return NSFetchRequest<MovieLocal>(entityName: "MovieLocal")
    }

    @NSManaged public var genre: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var overview: String?
    @NSManaged public var title: String?
    @NSManaged public var year: String?

}
