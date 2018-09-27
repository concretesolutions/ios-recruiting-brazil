//
//  AllGenresSingleton.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 24/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class AllGenresSingleton: NSObject {
    
    
    private override init() { }
    
    static var allGenres = Genres()
}
