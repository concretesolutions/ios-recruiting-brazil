//
//  FilterSelection.swift
//  Wonder
//
//  Created by Marcelo on 11/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class FilterSelection {
    var year = String()
    var genre = String()
    var yearIndexPath = IndexPath()
    var genreIndexPath = IndexPath()
    var searchArgument = String()
    
    
    init() {
        self.year = String()
        self.genre = String()
        self.yearIndexPath = IndexPath()
        self.genreIndexPath = IndexPath()
    }
    
    init(year: String, genre: String, yearIndexPath: IndexPath, genreIndexPath: IndexPath) {
        self.year = year
        self.genre = genre
        self.yearIndexPath = yearIndexPath
        self.genreIndexPath = genreIndexPath
    }

    
}
