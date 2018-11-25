//
//  PopularMovieInteractor.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class GenreFilterInteractor: GenreFilterInteractorInput {
    
    
    // MARK: - Properties
    var output: GenreFilterInteractorOutput!
    
    // MARK: - GenreFilterInteractorInput Functions
    func getGenres() {
        // Get only the genres from the favorite movies
        // Get Favorite Movies Genres Ids
        var genreIds: [Int] = []
        for favoriteMovie in FavoriteMovieCoreDataManager.favoriteMovies {
            for genreId in favoriteMovie.genreIds {
                genreIds.append(genreId)
            }
        }
        
        // Get genres based on their ids
        var genres: [Genre] = []
        MovieDataManager.fetchGenres { (status) in
            if status == .success {
                for genreId in genreIds {
                    for genre in MovieDataManager.genres {
                        if genreId == genre.id {
                            genres.append(genre)
                        }
                    }
                }
            }
            self.output.didGetGenres(genres: genres)
        }
    }
    
    func saveGenreFilter(genres: [Genre]) {
        
    }

}
