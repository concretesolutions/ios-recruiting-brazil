//
//  FiltersModel.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

enum Filters {
    enum FiltersType: CustomStringConvertible {
        case date
        case genre
        
        var description: String {
            switch self {
            case .date:
                return "Date"
            case .genre:
                return "Genre"
            }
        }
    }
    
    struct Request {
        var type: FiltersType
        
        struct Filters {
            var dateFilter: String?
            var genreFilter: String?
        }
    }
    
    struct Response {
        var movies: [Movie]
    }
    
    struct ViewModel {
        var movies: [Movie]
    }
    
    enum Option {
        struct Selected {
            var type: FiltersType
            var filterPredicate: String
            var filterName: String
        }
        
        struct Request {
            var type: FiltersType
        }
        
        struct Response {
            var filters: [String]
        }
        
        struct ViewModel {
            var filters: [String]
        }
    }
}
