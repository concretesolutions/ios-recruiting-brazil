//
//  Movie.swift
//  AppMovie
//
//  Created by Renan Alves on 25/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

typealias Genre = Dictionary<String,[Dictionary<String,Any>]>

struct MovieNowPlaying {
    var adult: Bool
    var backdropPath: UIImage
    var genre: Genre
    var id: Int
    var language: String
    var originalTitle: String
    var overview: String
    var popularity: Decimal
    var posterPath: UIImage
    var releaseDate: String
    var favorite: Bool
}

class Movie {
    
    var movie : MovieNowPlaying?
    
    init() {
        
    }
    
    init(_movieNP: Dictionary<String,Any>) {
        let adult = _movieNP[PropertiesMovieNowPlaying.adult.value] as? Bool ?? false
        let genre = _movieNP[PropertiesMovieNowPlaying.genre.value] as? Genre ?? Genre()
        let id = _movieNP[PropertiesMovieNowPlaying.id.value] as? Int ?? 0
        let language = _movieNP[PropertiesMovieNowPlaying.language.value] as? String ?? ""
        let originalTitle = _movieNP[PropertiesMovieNowPlaying.originalTitle.value] as? String ?? ""
        let overview = _movieNP[PropertiesMovieNowPlaying.overview.value] as? String ?? ""
        let popularity = _movieNP[PropertiesMovieNowPlaying.popularity.value] as? Decimal ?? 0.0
        let releaseDate = _movieNP[PropertiesMovieNowPlaying.releaseDate.value] as? String ?? ""
        let favorite = false
        
        var backDropImage : UIImage?
        if let nameImage = _movieNP[PropertiesMovieNowPlaying.backdropPath.value] as? String {
            MovieDAO.shared.requestImage(from: APILinks.posterPath.value, name: nameImage, imageFormate: "jpg", completion: { (backDropPath) in
                if let _img = backDropPath {
                    dispatchPrecondition(condition: .onQueue(.main))
                    backDropImage = _img
                }
            })
        }
        
        var posterImage : UIImage?
        if let nameImage = _movieNP[PropertiesMovieNowPlaying.posterPath.value] as? String {
            MovieDAO.shared.requestImage(from: APILinks.posterPath.value, name: nameImage, imageFormate: "jpg", completion: { (posterPath) in
                if let _img = posterPath {
                    dispatchPrecondition(condition: .onQueue(.main))
                    posterImage = _img
                }
            })
        }
        
        if let bdImage = backDropImage, let pImage = posterImage {
            self.movie = MovieNowPlaying(adult: adult, backdropPath: bdImage, genre: genre, id: id, language: language, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: pImage, releaseDate: releaseDate, favorite: favorite)
        }
    }
    
    func updateFavorite(){
        if let _favorite = self.movie?.favorite {
            if _favorite == true {
                self.movie?.favorite = false
            }else {
                self.movie?.favorite = true
            }
        }
    }
    
    func getImage(favorite: Bool) -> UIImage? {
        
        if (self.movie?.favorite) != nil {
            if favorite == false {
                if let img = UIImage(named: "favorite_empty_icon") {
                    return img
                }
            }else {
                if let img = UIImage(named: "favorite_full_icon") {
                    return img
                }
            }
        }
        return nil
    }
}
