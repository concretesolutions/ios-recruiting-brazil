//
//  GenreCollection.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 14/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

class GenreCollection {
    private var genres = [Genre]()
    
    init() {
        ServiceLayer.request(router: .getGenres) { (result: Result<GenreResponse, Error>) in
            switch result {
            case .success(let response):
                self.genres = response.genres
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func genres(for ids: [Int]) -> [Genre] {
        var genres = [Genre]()
        
        for genre in self.genres {
            if ids.contains(genre.id) {
                genres.append(genre)
            }
        }
        
        return genres
    }
}
