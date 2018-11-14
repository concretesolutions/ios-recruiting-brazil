//
//  Movie+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 14/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var release_date: String?

}
