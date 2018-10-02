//
//  PopularMovieResponse.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class PopularMovieResponse: Decodable {
    var id: Int
    var title: String
    var overview: String
    var releaseDate: String
}
