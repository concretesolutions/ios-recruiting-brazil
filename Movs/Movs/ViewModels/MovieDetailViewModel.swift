//
//  MovieDetailViewModel.swift
//  Movs
//
//  Created by Franclin Cabral on 1/20/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDetailProtocol: BaseViewModelProtocol {
    var movie: Variable<Movie> { get }
    var genres: Variable<String> { get }
    func isFavorited() -> Bool
    func favoriteMovie(favorited: Bool)
}

class MovieDetailViewModel: MovieDetailProtocol {
 
    var movie: Variable<Movie>
    var genres: Variable<String> = Variable<String>("")
    
    let dataStore = ManagerCenter.shared.factory.dataStore
    
    init(movie: Movie) {
        self.movie = Variable<Movie>(movie)
        self.genres = Variable<String>(self.getGenres(movie.genreIds))
        if self.isFavorited() {
            var newMovie = self.movie.value
            newMovie.favorited = self.isFavorited()
            self.movie = Variable<Movie>(newMovie)
        }
    }
    
    func getGenres(_ genresId: [Int]) -> String {
        let genres = dataStore.read(Genre.self, matching: nil)
        let genresInUse = genres.filter{ genresId.contains($0.id) }
        let names = genresInUse.map { $0.name }
        return names.joined(separator: ", ")
    }
    
    func isFavorited() -> Bool {
        let movies = dataStore.read(Movie.self, matching: nil)
        guard let movie = (movies.first { $0.id == self.movie.value.id }) else {
            return false
        }
        return movie.favorited
    }
    
    func favoriteMovie(favorited: Bool) {
        if favorited {
            var newMovie = self.movie.value
            newMovie.favorited = favorited
            do {
                try dataStore.create(newMovie, update: true)
            } catch let error {
                print(error.localizedDescription)
            }
            self.movie = Variable<Movie>(newMovie)
        } else {
            do {
                try dataStore.delete(self.movie.value)
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
