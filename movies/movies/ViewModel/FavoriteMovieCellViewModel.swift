//
//  FavoriteMovieCellViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class FavoriteMovieCellViewModel: ObservableObject {
    private static let dateFormatter: DateFormatter = {
        $0.dateFormat = "YYYY"
        return $0
    }(DateFormatter())
    
    private var movie: Movie
    
    var title: String {
        return self.movie.title
    }
    
    var date: String {
        return FavoriteMovieCellViewModel.dateFormatter.string(from: self.movie.releaseDate)
    }
    
    var overview: String {
        return self.movie.overview
    }
    
    @Published var poster: Data = Data()

    init(of movie: Movie) {
        self.movie = movie
    }
    
    private func downloadPoster() {
        URLSession.shared.dataTask(with: self.movie.posterURL) { (data, _, _) in
            guard let data = data else { return }
            self.poster = data
        }
    }
}
