//
//  MoviesModel.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/2/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit


struct MoviesModel {
    let movieTitle: String
    let posterImage: String
    let releaseDate: String
    let genreIds: [Int]
    let overview: String
    
    ///Computed Property
    ///Get Genre Id and convert to Genre literal
    var genreNames: [String] {
        var genreName: [String] = []
        for index in genreIds {
            let idToString = associateId(ids: index)
            genreName.append(idToString)
        }
        return genreName
    }
    
    func associateId(ids: Int) -> String {
        switch ids {
        case 28:
            return "Action"
        case 12:
            return "Adventure"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 10751:
            return "Family"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 10402:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Science Fiction"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10752:
            return "War"
        case 37:
            return "Western"
        default:
            return "Code does not exist"
        }
    }
    
}
