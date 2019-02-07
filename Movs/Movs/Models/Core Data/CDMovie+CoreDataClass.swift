//
//  CDMovie+CoreDataClass.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CDMovie)
public class CDMovie: NSManagedObject {
  
  convenience init(movie: Movie, genres: [Genre], context: NSManagedObjectContext) {
    let newMovie = NSEntityDescription.entity(forEntityName: "CDMovie", in: context)!
    self.init(entity: newMovie, insertInto: context)
    self.id = Int32(movie.id)
    self.title = movie.title
    self.overview = movie.overview
    self.posterPath = movie.posterPath
    self.releaseDate = movie.releaseDate
    self.genres = []
    genres.forEach {
      self.genres?.append($0.name)
    }
  }
}
