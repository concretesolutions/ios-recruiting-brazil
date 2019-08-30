//
//  MovieDetail.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 27/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation
import CoreData

@objc(MovieDetail)
public class MovieDetail: NSManagedObject {
    
    static let name = "MovieDetail"
    
    convenience init(id: String, overview: String, poster_path: String, release_date: String, title: String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: MovieDetail.name, in: context) {
            self.init(entity: ent, insertInto: context)
            self.id = id
            self.overview = overview
            self.poster_path = poster_path
            self.release_date = release_date
            self.title = title
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
