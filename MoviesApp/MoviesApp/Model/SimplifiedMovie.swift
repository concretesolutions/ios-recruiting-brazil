//
//  SimplifiedMovie.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


//MARK: - Protocol with the used parts of the movie in the application
protocol MoviePresentable {
    var id: Int {get}
    var name: String {get}
    var bannerImage: String? {get}
    var description: String {get}
    var genres: [Int] {get}
    var date: String {get}
}


//MARK: - Validates the movie and filter the unused parts
class SimplifiedMovie: MoviePresentable{
    var id: Int
    var name: String
    var bannerImage: String?
    var description: String
    var genres: [Int]
    var date: String
    
    init(movie: Movie) {
        self.id = movie.id
        self.name = movie.original_title
        self.description = movie.overview
        self.genres = movie.genre_ids
        self.date = movie.release_date
        self.bannerImage = movie.poster_path
        
    }
}
