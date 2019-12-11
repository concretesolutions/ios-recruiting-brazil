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
        $0.dateFormat = "MMM, YYYY"
        return $0
    }(DateFormatter())
    
    private var movie: Movie
    
    var title: String {
        return self.movie.title
    }
    
    var date: String {
        guard let releaseDate = self.movie.releaseDate else { return "Upcoming" }
        return MovieDetailsViewModel.dateFormatter.string(from: releaseDate)
    }
    
    var genres: String {
        guard let genres = self.movie.genreIds?.reduce("", { (genres, genre) -> String in
            "\(genres), \(MovieService.genres[genre] ?? "")"
        }) else {
            return ""
        }

        return String(genres.dropFirst(2))
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
        self.favorite = UserDefaults.standard.isFavorite(self.movie.id)
               
        _ = UserDefaults.standard.publisher(for: \.favorites)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let id = self?.movie.id else { return }
                self?.favorite = UserDefaults.standard.isFavorite(id)
            })
    }
    
    public func toggleFavorite() {
        UserDefaults.standard.toggleFavorite(withId: self.movie.id)
    }
}
