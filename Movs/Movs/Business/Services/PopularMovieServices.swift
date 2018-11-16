//
//  PopularMovieServices.swift
//  Movs
//
//  Created by Adann Simões on 16/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

struct PopularMovieServices {
    static func getPopularMovieList(completionHandler: @escaping (PopularMovie?) -> Void) {
        PopularMovieDAO.getPopularMovieList(completionHandler: completionHandler)
    }
}
