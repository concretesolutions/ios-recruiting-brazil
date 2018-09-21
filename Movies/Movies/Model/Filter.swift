//
//  Filter.swift
//  Movies
//
//  Created by Jonathan Martins on 20/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation

class Filter {

    static let current = Filter()
    
    /// Indicates if there are active filters
    var hasFilters:Bool = false
    
    /// Indicates the genre of a movie
    var genre:Genre?
    
    /// Indicates the date of a movie
    var date:String?

    /// Resets all fikters
    func resetAll(){
        date  = nil
        genre = nil
        hasFilters = false
    }
}
