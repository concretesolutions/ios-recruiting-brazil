//
//  Movie.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 20/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import Combine
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    @NSManaged var movieID: String?
    @NSManaged var title: String?
    @NSManaged var overview: String?
    @NSManaged var posterPath: String?
    @NSManaged var genres: [Int]?
    @NSManaged var isFavorite: Bool
    @NSManaged var releaseDate: String?
 
    public var notification = PassthroughSubject<Void, Never>()
}
