//
//  GenreServices.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

struct GenreServices {
    static func getGenreList(completionHandler: @escaping (GenreList?, Error?) -> Void) {
        GenreDAO.getGenre(completionHandler: completionHandler)
    }
}
