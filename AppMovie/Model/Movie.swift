//
//  Movie.swift
//  AppMovie
//
//  Created by Renan Alves on 25/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

typealias Genre = [String]

struct Movie {
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

extension Movie {
    
    init(_movieNP: Dictionary<String,Any>) {
        let adult = _movieNP[PropertieMovie.adult.value] as? Bool ?? false
        let id = _movieNP[PropertieMovie.id.value] as? Int ?? 0
        let language = _movieNP[PropertieMovie.language.value] as? String ?? ""
        let originalTitle = _movieNP[PropertieMovie.originalTitle.value] as? String ?? ""
        let overview = _movieNP[PropertieMovie.overview.value] as? String ?? ""
        let popularity = _movieNP[PropertieMovie.popularity.value] as? Decimal ?? 0.0
        var genreStrin = Genre()
        if let genreInt = _movieNP[PropertieMovie.genre.value] as? [Int], !genreInt.isEmpty {
            genreStrin = self.setupGenres(movieGenres: genreInt)
        }
        var releaseDate = Date()
        if let release = _movieNP[PropertieMovie.releaseDate.value] as? String {
            if let dateConverted = Date.convertDateFormatter(stringDate: release) {
                releaseDate = dateConverted
            }
        }
        let favorite = false
        var backDropImage : UIImage?
        if let nameImage = _movieNP[PropertieMovie.backdropPath.value] as? String {
            MovieDAO.shared.requestImage(from: APILinks.posterPath.value, name: nameImage, imageFormate: PropertieExtensionImages.jpg.value, completion: { (backDropPath) in
                if let _img = backDropPath {
                    dispatchPrecondition(condition: .onQueue(.main))
                    backDropImage = _img
                }
            })
        }
        
        var posterImage : UIImage?
        if let nameImage = _movieNP[PropertieMovie.posterPath.value] as? String {
            MovieDAO.shared.requestImage(from: APILinks.posterPath.value, name: nameImage, imageFormate: PropertieExtensionImages.jpg.value, completion: { (posterPath) in
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
                if let dicId = dicGenres[PropertieGenres.id.value] as? Int {
                    if  dicId == myGenereID {
                        if let genre = dicGenres[PropertieGenres.name.value] as? String {
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
