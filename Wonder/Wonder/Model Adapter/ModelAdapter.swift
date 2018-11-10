//
//  ModelAdapter.swift
//  Wonder
//
//  Created by Marcelo on 10/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class ModelAdapter {
    func convertToBusiness(_ favoriteMovie: FavoriteMovies) -> Results {
        let movie = Results()
        movie.release_date = favoriteMovie.year!
        movie.overview = favoriteMovie.overview!
        movie.genre_ids = self.getGenresIds(genresString: favoriteMovie.genre!)
        movie.title = favoriteMovie.title!
        movie.id = Int(favoriteMovie.id!)!
        movie.poster_path = favoriteMovie.poster!
 
        return movie
    }
    
    
    private func getGenresIds(genresString: String) -> [Int] {
        var ids = [Int]()
        let components = genresString.split(separator: ",")
        for item in components {
            let i = getGenreId(String(item))
            if i >= 0 {
                ids.append(i)
            }
        }
        return ids
    }
    
    private func getGenreId(_ inputString: String) -> Int {
        for genre in AppSettings.standard.genresList.genres {
            if genre.name == inputString {
                return genre.id
            }
        }
        return -1
    }
    
}
