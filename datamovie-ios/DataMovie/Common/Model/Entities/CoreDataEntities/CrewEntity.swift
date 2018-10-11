//
//  CrewEntity.swift
//  DataMovie
//
//  Created by Andre Souza on 29/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import CoreData

@objc(CrewEntity)
public class CrewEntity: NSManagedObject, FetchableProtocol {
    
    @NSManaged public var creditID: String
    @NSManaged public var personID: Int32
    @NSManaged public var name: String
    @NSManaged public var profilePicture: String
    @NSManaged public var department: String
    @NSManaged public var movies: Set<MovieEntity>
    
}

// MARK: Generated accessors for movies

extension CrewEntity {
    
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

extension CrewEntity {
    
    convenience private init() {
        self.init(context: CoreDataStack.sharedInstance.persistentContainer.viewContext)
    }
    
}
