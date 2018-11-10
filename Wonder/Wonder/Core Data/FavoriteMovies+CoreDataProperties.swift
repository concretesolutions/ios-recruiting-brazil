//
//  FavoriteMovies+CoreDataProperties.swift
//  
//
//  Created by Marcelo on 09/11/18.
//
//

import Foundation
import CoreData


extension FavoriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovies> {
        return NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
    }

    @NSManaged public var year: String?
    @NSManaged public var overview: String?
    @NSManaged public var genre: String?
    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var poster: String?

}
