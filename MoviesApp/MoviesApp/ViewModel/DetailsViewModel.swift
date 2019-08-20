//
//  DetailsViewModel.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit

//MARK: - Interface
protocol DetailsInterface{
    func detailsGenres() -> String
    func addFavorite()
    func checkFavorite(movieID: Int)
}

//MARK: - Init
class DetailsViewModel: DetailsInterface{
    var movie: PresentableMovieInterface
    var isFavorite: Bool = false
    var displayImage: String = ""
    var crud: FavoriteCRUDInterface
    
    init(crud: FavoriteCRUDInterface,movie: PresentableMovieInterface) {
        self.crud = crud
        self.movie = movie
    }

//MARK: - Methods
    
    //Transformes the genres list in a simple string
    func detailsGenres() -> String {
        var genreSring = ""
        for genre in movie.genres{
            genreSring = genreSring + " \(genre.name),"
        }
        genreSring.removeLast()
        return genreSring
    }
    
    //Add a favorite to the data base when the button is pressed
    func addFavorite(){
        if !isFavorite{
            crud.addFavorite(movie: movie)
            isFavorite = true
        }else{
            print("Ja foi favoritado")
        }
    }
    
    //Check if a movie is a favorite to display in the grid
    func checkFavorite(movieID: Int){
        isFavorite = crud.checkFavoriteMovie(movieId: "\(movieID)")
    }
}
