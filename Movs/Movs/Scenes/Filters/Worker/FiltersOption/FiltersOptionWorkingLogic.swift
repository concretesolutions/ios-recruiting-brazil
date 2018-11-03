//
//  FiltersOptionWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersOptionWorkingLogic {
    func fetchGenres(completion: @escaping (GenreList?, Error?) -> ())
}
