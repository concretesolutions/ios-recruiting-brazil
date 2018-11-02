//
//  FilterManager.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 01/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation

protocol FilterInterfaceProtocol {
    func reload()
}

class FilterManager {
    var interface: FilterInterfaceProtocol?
    var movieProvider = MovieProvider()
    var filterProvider = FilterProvider()
    
    var allGenres: [Genre] = []
    var filter = Filter()
    
    init(_ interface: FilterInterfaceProtocol) {
        self.interface = interface
        
    }
    
    func fetchGenres() {
        if let filter = self.filterProvider.load() {
            self.filter = filter
            self.interface?.reload()
        }
        
        self.movieProvider.fetchGenres { genres in
            self.allGenres = genres
            self.interface?.reload()
        }
    }
    
    func numberOfFilterOptions() -> Int {
        return self.filter.genres.count + self.filter.years.count
    }
    
    func genreIn(index: Int) -> String {
        return self.allGenres[index].name
    }
    
    func filterOptionIn(index: Int) -> Any? {
        
        let count = filter.genres.count
        
        if index < count {
            return self.filter.genres[index]
        }
        
        if index - count < self.filter.years.count {
            return self.filter.years[index - count]
        }
        
        return ""
    }
    
    func numberOfYears() -> Int {
        return 200
    }
    
    func numberOfGenres() -> Int {
        return allGenres.count
    }
    
    func add(year: Int) {
        if !self.filter.years.contains(year) {
            self.filterProvider.add(year: year, in: self.filter)
            self.interface?.reload()
        }
        
    }
    
    func add(genreIndex: Int) {
        if genreIndex < self.allGenres.count &&
            !self.filter.genres.contains(self.allGenres[genreIndex]){
            self.filterProvider.add(genre: self.allGenres[genreIndex], in: self.filter)
            self.interface?.reload()
        }
    }
    
    func delete(year: Int?, genre: Genre?) {
        if let year = year {
            self.filterProvider.delete(year: year, in: self.filter)
        }
        
        if let genre = genre {
            self.filterProvider.delete(genre: genre, in: self.filter)
        }
        
        self.interface?.reload()
    }
    
    func saveFilter() {
        self.filterProvider.save(filter: self.filter)
    }
    
    func removeFilter() {
        self.filterProvider.clear(filter: self.filter)
        self.interface?.reload()
    }
}
