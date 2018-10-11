//
//  GenreEntity+CoreDataClass.swift
//  DataMovie
//
//  Created by Andre Souza on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//
//

import Foundation
import CoreData

@objc(GenreEntity)
public class GenreEntity: NSManagedObject, FetchableProtocol {
    
    @NSManaged public var genreID: Int32
    @NSManaged public var name: String
    @NSManaged public var movies: Set<MovieEntity>
    
}

// MARK: Generated accessors for movies

extension GenreEntity {
    
    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieEntity)
    
    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieEntity)
    
    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: Set<MovieEntity>)
    
    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: Set<MovieEntity>)
    
}

// MARK: - Custom init -

extension GenreEntity {
    
    convenience private init() {
        self.init(context: CoreDataStack.sharedInstance.persistentContainer.viewContext)
    }

}
