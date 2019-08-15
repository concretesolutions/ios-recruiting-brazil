//
//  DetailsViewModel.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit

class DetailsViewModel{
    var movie: SimplifiedMovie?
    var isFavorite: Bool = false
    
    //Transformes the genres list in a simple string
    func detailsGenres() -> String {
        var genreSring = ""
        
        if let genres = movie?.genres {
            for genre in genres{
                genreSring = genreSring + " \(genre.name),"
            }
            genreSring.removeLast()
        }
        return genreSring
    }
    
    //Add a favorite to the data base when the button is pressed
    func addFavorite(){
        if !isFavorite{
            if let secureMovie = movie{
                FavoriteCRUD.sharedCRUD.addFavorite(movie: secureMovie)
                isFavorite = true
            }else{
                print("Error adding the favorite")
            }
        }else{
            print("Ja foi favoritado")
        }
    }
}
