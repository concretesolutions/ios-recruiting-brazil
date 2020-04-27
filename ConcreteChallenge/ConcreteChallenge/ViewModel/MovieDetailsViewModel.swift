//
//  MovieDetailsViewModel.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

struct MovieDetailsViewModel: Equatable {
    let details: MovieDetails?
    
    init(state: RootState) {
        details = state.movie.currentMovieDetails
    }
}
