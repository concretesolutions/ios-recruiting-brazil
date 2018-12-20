//
//  TMDBError.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

public enum TMDBError:Error{
    case buildingURL(String)
    case gettingData(String)
    case jsonSerialization(String)
}

