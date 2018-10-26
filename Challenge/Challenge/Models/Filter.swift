//
//  Filter.swift
//  Challenge
//
//  Created by Sávio Berdine on 26/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import Foundation

class Filter {
    var genre: String?
    var year: String?
    
    static var filterState = Filter()
    
    init() {
        self.genre = ""
        self.year = ""
    }
    
    class func filter(movies: [Movie], onSuccess: @escaping (_ movies: [Movie]) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        var moviesResult: [Movie] = []
        if Filter.filterState.genre != "" &&  Filter.filterState.year != "" {
            moviesResult = movies.filter({$0.genre.read().containsSubstring(find: Filter.filterState.genre!) && $0.date?.dateToYyyyWithDashes() == Filter.filterState.year!})
            onSuccess(moviesResult)
        }
        else if Filter.filterState.genre != "" &&  Filter.filterState.year == "" {
           moviesResult = movies.filter({$0.genre.read().containsSubstring(find: Filter.filterState.genre!)})
            onSuccess(moviesResult)
        }
        else if Filter.filterState.genre == "" &&  Filter.filterState.year != "" {
            moviesResult = movies.filter({$0.date?.dateToYyyyWithDashes() == Filter.filterState.year!})
            onSuccess(moviesResult)
        } else {
            moviesResult = []
            onSuccess(moviesResult)
        }
    }
    
}
