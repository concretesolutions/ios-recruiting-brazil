//
//  MovieCellViewModel.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    
    var movie: Movie
    
    init(with movie: Movie) {
        self.movie = movie
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    var bannerData: Data {
        return Data()
    }
    
    var isFavorite: Bool {
        return movie.isFavorite
    }
    
    func didTapFavorite() {
        
        movie.isFavorite = !movie.isFavorite
        
        // TODO: Persist the favorite somewhere
        
    }
    
}
