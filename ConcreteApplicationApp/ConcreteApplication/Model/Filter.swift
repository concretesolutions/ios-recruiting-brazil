//
//  Filter.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 27/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

struct Filter{
    
    var genre: String?
    var releaseYear: String?
    
    init() {
        self.genre = nil
        self.releaseYear = nil
    }
    
    mutating func updateParameter(of type: FilterOptions, with value: String){
        switch type {
        case .date:
            self.releaseYear = value
        case .genre:
            self.genre = value
        }
    }
    
}
