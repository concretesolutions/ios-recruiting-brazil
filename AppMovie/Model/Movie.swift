//
//  Movie.swift
//  AppMovie
//
//  Created by Renan Alves on 25/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

typealias Genre = [String]

struct MovieNowPlaying {
    var adult = Bool()
    var backdropPath = UIImage()
    var genre = Genre()
    var id = Int()
    var language = String()
    var originalTitle = String()
    var overview = String()
    var popularity = Decimal()
    var posterPath = UIImage()
    var releaseDate = Date()
    var favorite = Bool()
}

extension MovieNowPlaying {
    
    init(_movieNP: Dictionary<String,Any>) {
        let adult = _movieNP[PropertireMovie.adult.value] as? Bool ?? false
        let id = _movieNP[PropertireMovie.id.value] as? Int ?? 0
        let language = _movieNP[PropertireMovie.language.value] as? String ?? ""
        let originalTitle = _movieNP[PropertireMovie.originalTitle.value] as? String ?? ""
        let overview = _movieNP[PropertireMovie.overview.value] as? String ?? ""
        let popularity = _movieNP[PropertireMovie.popularity.value] as? Decimal ?? 0.0
        var genreStrin = Genre()
        if let genreInt = _movieNP[PropertireMovie.genre.value] as? [Int], !genreInt.isEmpty {
            genreStrin = self.setupGenres(movieGenres: genreInt)
        }
        var releaseDate = Date()
        if let release = _movieNP[PropertireMovie.releaseDate.value] as? String {
            if let dateConverted = Dates.convertDateFormatter(stringDate: release) {
                releaseDate = dateConverted
            }
        }
        let favorite = false
        var backDropImage : UIImage?
        if let nameImage = _movieNP[PropertireMovie.backdropPath.value] as? String {
            MovieDAO.shared.requestImage(from: APILinks.posterPath.value, name: nameImage, imageFormate: "jpg", completion: { (backDropPath) in
                if let _img = backDropPath {
                    dispatchPrecondition(condition: .onQueue(.main))
                    backDropImage = _img
                }
            })
        }
        
        var posterImage : UIImage?
        if let nameImage = _movieNP[PropertireMovie.posterPath.value] as? String {
            MovieDAO.shared.requestImage(from: APILinks.posterPath.value, name: nameImage, imageFormate: "jpg", completion: { (posterPath) in
                if let _img = posterPath {
                    dispatchPrecondition(condition: .onQueue(.main))
                    posterImage = _img
                }
            })
        }
        
        if let bdImage = backDropImage, let pImage = posterImage {
            self.adult = adult
            self.backdropPath = bdImage
            self.id = id
            self.genre = genreStrin
            self.language = language
            self.originalTitle = originalTitle
            self.overview = overview
            self.popularity = popularity
            self.posterPath = pImage
            self.releaseDate = releaseDate
            self.favorite = favorite
        }
    }
    
    private func setupGenres(movieGenres: [Int]) -> [String]{
        var genreStrin = [String]()
        for dicGenres in MovieDAO.shared.genres {
            for myGenereID in movieGenres {
                if let dicId = dicGenres["id"] as? Int {
                    if  dicId == myGenereID {
                        if let genre = dicGenres["name"] as? String {
                            if genreStrin.isEmpty {
                                genreStrin.append("\(genre)")
                            }
                            genreStrin.append(",\(genre)")
                        }
                    }
                }
            }
        }
        return genreStrin
    }
    mutating func updateFavorite(){
            if self.favorite == true {
                self.favorite = false
            }else {
                self.favorite = true
            }
    }
    
    func getImage(favorite: Bool) -> UIImage? {
        
        if favorite == false {
            if let img = UIImage(named: "favorite_gray_icon") {
                return img
            }
        }else {
            if let img = UIImage(named: "favorite_full_icon") {
                return img
            }
        }
        return nil
    }
}
