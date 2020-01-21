//
//  Genre.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 09/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import Combine
import CoreData

@objc(Genre)
public class Genre: NSManagedObject {
    
    @NSManaged var idGenre: String?
    @NSManaged var name: String?
    
    public var notification = PassthroughSubject<Void, Never>()
}
