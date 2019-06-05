//
//  GenreModel.swift
//  GPSMovies
//
//  Created by Gilson Santos on 02/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation

class GenreModel : Codable {
    var genres : [Genres]?
}

class Genres : Codable {
    var id : Int64?
    var name : String?
}
