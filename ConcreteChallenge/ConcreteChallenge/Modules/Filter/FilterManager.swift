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
    
    var allGenres: [Genre] = []
    var genresSelected : [Genre] = []
    var yearSelected: [Int] = []
    
    init(_ interface: FilterInterfaceProtocol) {
        self.interface = interface
        fetchGenres()
    }
    
    func fetchGenres() {
        self.movieProvider.fetchGenres { genres in
            self.allGenres = genres
            self.interface?.reload()
        }
    }
    
    func numberOfFilterOptions() -> Int {
        return genresSelected.count + yearSelected.count
    }
    
    func genreIn(index: Int) -> String {
        return self.allGenres[index].name ?? "Error"
    }
    
    func filterOptionIn(index: Int) -> String {
        
        if index < self.genresSelected.count {
            
            return self.genresSelected[index].name ?? "Error"
        }
        
        return String(self.yearSelected[index - self.genresSelected.count])
    }
    
    func numberOfYears() -> Int {
        return 200
    }
    
    func numberOfGenres() -> Int {
        return allGenres.count
    }
    
    func add(year: Int) {
        self.yearSelected.append(year)
        self.interface?.reload()
    }
    
    func add(genreIndex: Int) {
        self.genresSelected.append(self.allGenres[genreIndex])
        self.interface?.reload()
    }
}
