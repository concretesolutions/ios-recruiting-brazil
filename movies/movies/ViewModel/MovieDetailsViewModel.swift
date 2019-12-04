//
//  MovieDetailsViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    private static let dateFormatter: DateFormatter = {
        $0.dateFormat = "YYYY"
        return $0
    }(DateFormatter())
    
    private var movie: Movie {
        didSet {
            self.favorite = self.movie.favorite
        }
    }
    
    var title: String {
        return self.movie.title
    }
    
    var date: String {
        return MovieDetailsViewModel.dateFormatter.string(from: self.movie.releaseDate)
    }
    
    var genres: String {
        guard let genres = self.movie.genreIds?.reduce("", { (genres, genre) -> String in
            "\(genres), \(MovieService.genres[genre] ?? "")"
        }) else {
            return ""
        }

        return String(genres.dropFirst())
    }
    
    var overview: String {
        return self.movie.overview
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
