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
        var genresById: [Genre] = []
        MovieDataManager.fetchGenres { (genres) in
            guard let genres = genres else { return }
            
            for genreId in genreIds {
                for genre in genres {
                    if genreId == genre.id {
                        genresById.append(genre)
                    }
                }
            }
            
            // Remove repeated Genres
            var noRepeatedGenres: [Genre] = []
            var shouldAdd = true
            for genre in genresById {
                for noRepeatedGenre in noRepeatedGenres {
                    if noRepeatedGenre.id == genre.id {
                        shouldAdd = false
                    }
                }
                if shouldAdd {
                    noRepeatedGenres.append(genre)
                }
                shouldAdd = true
            }
            self.output.didGetGenres(genres: noRepeatedGenres)
        }
    }
    
    func saveGenreFilter(genres: [Genre]) {
        FavoriteMovieCoreDataManager.genresFilter = genres
    }

}
