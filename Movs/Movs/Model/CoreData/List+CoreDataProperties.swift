//
//  List+CoreDataProperties.swift
//  Movs
//
//  Created by Ygor Nascimento on 04/05/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var movies: NSOrderedSet?

}

// MARK: Generated accessors for movies
extension List {

    @objc(insertObject:inMoviesAtIndex:)
    @NSManaged public func insertIntoMovies(_ value: FavoriteMovie, at idx: Int)

    @objc(removeObjectFromMoviesAtIndex:)
    @NSManaged public func removeFromMovies(at idx: Int)

    @objc(insertMovies:atIndexes:)
    @NSManaged public func insertIntoMovies(_ values: [FavoriteMovie], at indexes: NSIndexSet)

    @objc(removeMoviesAtIndexes:)
    @NSManaged public func removeFromMovies(at indexes: NSIndexSet)

    @objc(replaceObjectInMoviesAtIndex:withObject:)
    @NSManaged public func replaceMovies(at idx: Int, with value: FavoriteMovie)

    @objc(replaceMoviesAtIndexes:withMovies:)
    @NSManaged public func replaceMovies(at indexes: NSIndexSet, with values: [FavoriteMovie])

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: FavoriteMovie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: FavoriteMovie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSOrderedSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSOrderedSet)

}
