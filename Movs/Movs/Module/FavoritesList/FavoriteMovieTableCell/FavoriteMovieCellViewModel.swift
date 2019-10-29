//
//  FavoriteMovieCellViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class FavoriteMovieCellViewModel {
    private(set) var movie: Movie
    
    let titleText: String
    let descriptionText: String
    private(set) var yearText: String = ""
    
    init(with movie: Movie) {
        self.movie = movie
        self.titleText = movie.title
        self.descriptionText = movie.overview
        
        if let releaseDate = movie.releaseDate {
            self.yearText = releaseDate.yearString
        }
    }
}
