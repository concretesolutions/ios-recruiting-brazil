//
//  Filter.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

struct Filter {

    var genre: String?
    var releaseYear: String?

    init() {
        self.genre = nil
        self.releaseYear = nil
    }

    mutating func updateParameter(of type: FilterOptions, with value: String) {
        switch type {
        case .date:
            self.releaseYear = value
        case .genre:
            self.genre = value
        }
    }

}
