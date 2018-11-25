//
//  Filter.swift
//  Movs
//
//  Created by Erick Lozano Borges on 22/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

struct Filter {
    //MARK: - Properties
    var genre: String?
    var releaseYear: String?
    
    //MARK: - Initializers
    init() {
        self.genre = nil
        self.releaseYear = nil
    }
    
    //MARK: - Mutating Methods
    mutating func updateParameter(ofType type: FilterParameterType, withValue value: String?) {
        switch type {
        case .genre: self.genre = value
        case .releaseYear: self.releaseYear = value
        }
    }
    
    mutating func clear() {
        self.genre = nil
        self.releaseYear = nil
    }
    
    //MARK: - Status Methods
    func isEmpty() -> Bool {
        return genre == nil && releaseYear == nil
    }
    
}
