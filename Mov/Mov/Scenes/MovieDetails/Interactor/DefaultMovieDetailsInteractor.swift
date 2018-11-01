//
//  DefaultMovieDetailsInteractor.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


final class DefaultMovieDetailsInteractor {
    
    let persistence: FavoritesPersistence
    
    init(persistence: FavoritesPersistence) {
        self.persistence = persistence
    }
    
    func movieDetailsUnit(from movie: Movie) -> MovieDetailsUnit {
        
    }
    
}

extension DefaultMovieDetailsInteractor: MovieDetaisInteractor {
    func getDetails(of movie: Movie) {
        
    }
    
}
