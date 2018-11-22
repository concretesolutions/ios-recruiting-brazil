//
//  Response.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 22/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation

struct Response: DataObject {
    var results: [Movie]
    var page: Int
    var total_results: Int
    var total_pages: Int
}
