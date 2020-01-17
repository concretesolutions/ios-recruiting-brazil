//
//  GenresService.swift
//  theMovie-app
//
//  Created by Adriel Alves on 13/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation


protocol GenresService {
    
    func requestGenreList(completion: @escaping (Result<GenreList, APIError>) -> Void)
    func movieGenresList(genresIds: [Int])
}
