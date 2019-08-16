//
//  TMDBError.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

public enum TMDBError: Error {
    case buildingURL(String)
    case gettingData(String)
    case jsonSerialization(String)
}
