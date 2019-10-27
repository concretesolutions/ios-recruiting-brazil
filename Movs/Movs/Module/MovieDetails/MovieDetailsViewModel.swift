//
//  MovieDetailsViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieDetailsViewModel {
    private(set) var movie: Movie
    
    private(set) var posterImg: UIImage
    private(set) var titleText: String
    private(set) var yearText: String = ""
    private(set) var genresText: String
    private(set) var descriptionText: String
    
    init(with movieCellViewModel: MovieCellViewModel) {
        self.movie = movieCellViewModel.movie
        
        self.posterImg = movieCellViewModel.posterImage
        self.titleText = movie.title
        
        if let releaseDate = self.movie.releaseDate {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: releaseDate)
            self.yearText = "\(year)"
        }
        
        self.genresText = "Animation, Musical" // TODO: get genre strings from API
        self.descriptionText = self.movie.overview
    }
}
