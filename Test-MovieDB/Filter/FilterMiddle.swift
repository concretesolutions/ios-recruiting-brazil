//
//  FilterMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 07/07/19.
//  Copyright © 2019 Gabriel Sória Souza. All rights reserved.
//

import Foundation

protocol FilterMiddleDelegate: class {
    
}

class FilterMiddle {
    
    private let tableViewData = FilterData()
    weak var delegate: FilterMiddleDelegate?
    var genres: Int?
    var period: Int?
    
    var rowNames: [String] {
        return tableViewData.rowNames
    }
    
    var rowCount: Int {
        return tableViewData.rowNames.count
    }
    
    var filter: [ChosenFilter] = [.date, .genre]
    
    init(delegate: FilterMiddleDelegate) {
        self.delegate = delegate
    }
}

struct FilterData {
    let rowNames = ["Date", "Genre"]
}
