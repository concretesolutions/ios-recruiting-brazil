//
//  MovieDetail+CoreDataProperties.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 27/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation
import CoreData

extension MovieDetail {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetail> {
        return NSFetchRequest<MovieDetail>(entityName: "MovieDetail")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    
}
