//
//  FilterTypeEnum.swift
//  movs
//
//  Created by Emerson Victor on 09/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

enum FilterType: Int, CaseIterable {
    case date = 0
    case genre = 1
    
    var stringValue: String {
        switch self {
        case .date:
            return "Date"
        case .genre:
            return "Genre"
        }
    }
}
