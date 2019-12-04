// swiftlint:disable identifier_name

//
//  MovieCellViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    
    // MARK: - Attributes
    
    public let id: Int
    public let poster: UIImage?
    public let releaseDate: String
    public let title: String
    public let overview: String
    
    // MARK: - Initializers
    
    init(movie: MovieDTO) {
        self.id = movie.id
        self.poster = UIImage(named: "placeholder") // TODO: Request image
        self.releaseDate = movie.releaseDate
        self.title = movie.title
        self.overview = movie.overview
    }
}
