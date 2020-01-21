//
//  MoviesVC+MoviesCollectionCellDelegate.swift
//  Movs
//
//  Created by Rafael Douglas on 20/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

extension MoviesVC: MoviesCollectionCellDelegate{
    func didTapFavoritedBtn(movie: Movie) {
        let movieWasAdded = CoreDataDelegate.movieWasAdded(movie: movie)
        if(movieWasAdded == false){
            //Creating an instance from DB
            moviesDB = Movies(context: context)
            if let movieId = movie.id {
                moviesDB.id = Int32(movieId)
            }
            if let movieTitle = movie.title {
                moviesDB.title = movieTitle
            }
            if let movieOverview = movie.overview {
                moviesDB.overview = movieOverview
            }
            if let movieVoteAverage = movie.vote_average {
                moviesDB.vote_average = movieVoteAverage
            }
            if let moviePosterPath = movie.poster_path {
                moviesDB.poster_path = moviePosterPath
            }
            if let movieReleaseDate = movie.release_date {
                moviesDB.release_date = movieReleaseDate
            }
            
            do {
               try context.save()
            } catch {
               print(error.localizedDescription)
            }
        }else{
            print("movie has already been added!")
        }
    }
}
