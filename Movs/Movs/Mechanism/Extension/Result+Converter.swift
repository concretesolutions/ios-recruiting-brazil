//
//  Favorite+Converter.swift
//  Movs
//
//  Created by Adann Simões on 18/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

extension Result {
    func convertResultInFavorite(with genre: String) -> Favorite {
        let favorite = Favorite()
        favorite.releaseDate = self.releaseDate as NSDate?
        favorite.overview = self.overview
        favorite.backdropPath = self.backdropPath
        favorite.genres = genre
        favorite.originalTitle = self.originalTitle
        favorite.posterPath = self.posterPath
        favorite.title = self.title
        if let voteAverage = self.voteAverage {
            favorite.voteAverage = voteAverage
        }
        if let id = self.id {
            favorite.id = Int32(id)
        }
        
        // Salvando as info abaixo, mas não estão sendo usadas atualmente
        if let adult = self.adult {
            favorite.adult = adult
        }
        favorite.originalLanguage = self.originalLanguage
        if let popularity = self.popularity {
            favorite.popularity = popularity
        }
        if let video = self.video {
            favorite.video = video
        }
        if let voteCount = self.voteCount {
            favorite.voteCount = Int32(voteCount)
        }
        
        return favorite
    }
}
