//
//  MovieGridViewModel.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

struct MovieGridViewModel: Equatable {
    let title: String
    let poster: UIImage
    let isFavoriteIcon: UIImage
    
    static let placeHolder = MovieGridViewModel(title: "Movie", poster: Images.poster_placeholder, isFavoriteIcon: Images.isFavoriteIconGray)
}
