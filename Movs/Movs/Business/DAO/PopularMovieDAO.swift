//
//  PopularMovieDAO.swift
//  Movs
//
//  Created by Adann Simões on 16/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

struct PopularMovieDAO {
    static func getPopularMovieList(completionHandler: @escaping (PopularMovie?) -> Void) {
        let endpoint = "\(APIRoute.base.rawValue + APIRoute.popularMovie.rawValue)"
        
    }
}
