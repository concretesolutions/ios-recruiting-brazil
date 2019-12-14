//
//  CoreDataFactory.swift
//  Movs
//
//  Created by Gabriel D'Luca on 12/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import CoreData

protocol CoreDataFactory {
    func createFavoriteMovie(movie: Movie, description: NSEntityDescription) -> CDFavoriteMovie
}
