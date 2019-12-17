//
//  Enum.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation

enum errorType {
    case undefined, search, none
}

enum StoryboardType: String {
    case main

    var name: String {
        return self.rawValue.capitalized
    }
}

enum CookieName: String {
    case movie = "cookie_movie"

    internal func movieNameId(id: Int) -> String {
        return "\(self.rawValue)_\(id)"
    }

}
