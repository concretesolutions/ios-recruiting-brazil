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
        guard let genres = self.movie.genres?.reduce("", { (genres, genre) -> String in
            "\(genres), \(genre.name)"
        }) else {
            return ""
        }
        
        return String(genres.dropFirst())
    }
    
    var overview: String {
        return self.movie.overview
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
