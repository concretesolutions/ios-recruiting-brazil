//
//  MovieListWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListWorkingLogic {
    func fetch(page: Int, completion: @escaping (MoviesList, MovieList.Response.Status, Error?) -> ())
}
