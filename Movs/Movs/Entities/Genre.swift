//
//  Genre.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation

// TODO: tradução, ta em portugues pra simplificar
enum Genre: String, Encodable {
    case action = "Action",
         adventure = "Adventure",
         animation = "Animation",
         comedy = "Comedy",
         crime = "Crime",
         documentary = "Documentary",
         drama = "Drama",
         family = "Family",
         fantasy = "Fantasy",
         history = "History",
         horror = "Horror",
         music = "Music",
         mystery = "Mystery",
         romance = "Romance",
         scienceFiction = "Science Fiction",
         tvMovie = "TV Movie",
         thriller = "Thriller",
         war = "War",
         western = "Western",
         other = "Other"
}

extension Genre {
    init(id: Int) {
        switch id {
        case 28:
            self = .action
        case 12:
            self = .adventure
        case 16:
            self = .animation
        case 35:
            self = .comedy
        case 80:
            self = .crime
        case 99:
            self = .documentary
        case 18:
            self = .drama
        case 10751:
            self = .family
        case 14:
            self = .fantasy
        case 36:
            self = .history
        case 27:
            self = .horror
        case 10402:
            self = .music
        case 9648:
            self = .mystery
        case 10749:
            self = .romance
        case 878:
            self = .scienceFiction
        case 10770:
            self = .tvMovie
        case 53:
            self = .thriller
        case 10752:
            self = .war
        case 37:
            self = .western
        default:
            self = .other
        }
    }
}
