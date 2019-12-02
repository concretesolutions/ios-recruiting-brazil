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
    
    @Published var poster: Data = Data()
    @Published var favorite: Bool

    init(of movie: Movie) {
        self.movie = movie
        self.favorite = movie.favorite
    }
    
    public func toggleFavorite() {
        self.movie.favorite.toggle()
    }
    
    private func downloadPoster() {
        URLSession.shared.dataTask(with: self.movie.posterURL) { (data, _, _) in
            guard let data = data else { return }
            self.poster = data
        }
    }
}
