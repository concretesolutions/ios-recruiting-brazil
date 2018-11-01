//
//  MovieDetailsBuilder.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit


class MovieDetailsBuilder {
    static func build(forMovie movie: Movie) -> MovieDetailsViewController {
        let vc = MovieDetailsViewController(movie: movie)
        
        return vc
    }
}
