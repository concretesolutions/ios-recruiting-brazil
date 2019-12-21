//
//  Filter.swift
//  movies
//
//  Created by Jacqueline Alves on 16/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

protocol Filter {
    var name: String { get }
    var options: [String] { get set }
    var selected: CurrentValueSubject<[Int], Never> { get set }
    
    init(withOptions options: [String])
    func setOptions(_ options: [String])
    func filter(_ movies: [Movie]) -> [Movie]
    func copy() -> Filter
}

extension Filter {
    func copy() -> Filter {
        let copy = Self.init(withOptions: self.options)
        copy.selected.send(self.selected.value)
        
        return copy
    }
}

class ReleaseDateFilter: Filter {
    var name: String = "Date"
    var options: [String] = ["2019"] // Array of years
    var selected = CurrentValueSubject<[Int], Never>([])
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }()
    
    required init(withOptions options: [String] = []) {
        setOptions(options)
    }
    
    func setOptions(_ options: [String]) {
        self.options = options
    }
    
    func filter(_ movies: [Movie]) -> [Movie] {
        guard self.selected.value.isEmpty == false else { return movies }
        let selected = self.selected.value.map { options[$0] }
        
        return movies.filter { movie -> Bool in // Filter checking if options contains movie release date
            var date: String!
            
            if let releaseDate = movie.releaseDate {
                date = dateFormatter.string(from: releaseDate)
            } else {
                date = "Upcoming"
            }
            
            return selected.contains(date)
        }
    }
}

class GenreFilter: Filter {
    var name: String = "Genres"
    var options: [String] = ["Animation"] // Array of genre ids
    var selected = CurrentValueSubject<[Int], Never>([])
    var dict: [String: Int] = [:] // Dictionaty to map results
    
    /// Init with converter dictionatry
    /// - Parameters:
    ///   - options: Options
    ///   - dict: Options converter
    convenience init(withOptions options: [String], dict: [Int: String]) {
        self.init(withOptions: options)
        for (key, value) in dict { // Swap key and values in dictionay
            self.dict[value] = key
        }
    }
    
    required init(withOptions options: [String] = []) {
        setOptions(options)
    }
    
    func setOptions(_ options: [String]) {
        self.options = options
    }
    
    func filter(_ movies: [Movie]) -> [Movie] {
        guard self.selected.value.isEmpty == false else { return movies }
        
        let selected = self.selected.value.map { options[$0] }
        let selectedIds = selected.compactMap { self.dict[$0] } // Convert genre names with their ids

        return movies.filter { movie -> Bool in
            guard let genreIds = movie.genreIds else { return false }
            return selectedIds.filter { genreIds.contains($0) }.isEmpty == false
        }
    }
    
    func copy() -> Filter {
        let copy = Self.init(withOptions: self.options)
        copy.selected.send(self.selected.value)
        copy.dict = self.dict
        
        return copy
    }
}
