//
//  MovieDetailsViewModel.swift
//  Movie
//
//  Created by Elton Santana on 15/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsViewModel {
    
    var image: UIImage!
    var name: String!
    var year: String!
    var description: String!
    var isFavorited: Bool!
    var genre: String!
    
    private var movie: Movie
    
    var delegate: MovieDetailsDelegate?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchMovieDetails() {
        self.name = self.movie.title!
        self.description = self.movie.overview!
        self.isFavorited = DataProvider.shared.favoritesProvider.isFavorite(self.movie.id!)
        self.year = String(self.movie.releaseDate!.toDate()!.year)
        UIImage.loadFrom(self.movie.backdropPath!, completion: { (image, error) in
            if let error = error {
                print("Could not fetch image")
                print(error.localizedDescription)
            } else if let image = image {
                self.image = image
                DataProvider.shared.remoteDataProvider.getAllGenres(completion: { (genres, error) in
                    if let error = error {
                        print("Could not fetch genres")
                        print(error.localizedDescription)
                    } else if let genres = genres {
                        var movieGenresString = genres.filter({ (genre) -> Bool in
                            return self.movie.genreIDS!.contains(genre.id!)
                        }).reduce("", { (partial, genre) -> String in
                            return partial + genre.name! + ", "
                        })
                        if !movieGenresString.isEmpty {
                            movieGenresString.removeLast()
                            movieGenresString.removeLast()
                        }
                        self.genre = movieGenresString
                        self.delegate?.setupView()
                    }
                })
                
            }
            
        })
    }
    
    
    func handleFavoriteAction() {
        if self.isFavorited,
            let id = self.movie.id {
            let result = DataProvider.shared.favoritesProvider.delete(withId:id)
            self.isFavorited = result.contains(id)
        } else if let id = self.movie.id {
            let result = DataProvider.shared.favoritesProvider.addNew(withId: id)
            self.isFavorited = result.contains(id)
        }
        
        self.delegate?.updateUIFavoriteState()
    }
    
    
}


