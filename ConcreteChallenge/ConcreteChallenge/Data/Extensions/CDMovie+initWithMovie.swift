//
//  CDMovie+initWithMovie.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import CoreData

extension CDMovie {
    @discardableResult
    convenience init(movie: Movie, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = Int64(movie.id)
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
    }
}
