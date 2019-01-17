//
//  LocalDataHelper.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
class LocalDataHelper {
    static let shared = LocalDataHelper()
    private var genres: [GenreModel] = []
    
    func saveGenres(genres: [GenreModel]){
        self.genres = genres
    }
    
    func getGenres() -> [GenreModel]{
        return self.genres
    }
}
