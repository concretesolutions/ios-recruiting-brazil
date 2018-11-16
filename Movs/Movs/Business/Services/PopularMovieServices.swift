//
//  PopularMovieServices.swift
//  Movs
//
//  Created by Adann Simões on 16/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

struct PopularMovieServices {
    static func getPopularMovie(page: Int, completionHandler: @escaping (PopularMovie?, Error?) -> Void) {
        PopularMovieDAO.getPopularMovie(page: page, completionHandler: completionHandler)
    }
}
