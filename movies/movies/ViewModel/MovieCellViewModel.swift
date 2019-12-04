//
//  MovieCellViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MovieCellViewModel: ObservableObject {
    private var movie: Movie {
        didSet {
            self.favorite = self.movie.favorite
        }
    }
    
    var title: String {
        return self.movie.title
    }
    
    var posterURL: URL {
        return self.movie.posterURL
    }
    
    @Published var favorite: Bool

    init(of movie: Movie) {
        self.movie = movie
        self.favorite = movie.favorite
    }
    
    public func toggleFavorite() {
        self.movie.favorite.toggle()
    }
}
