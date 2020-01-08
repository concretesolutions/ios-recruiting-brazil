//
//  MovieDetailViewModel.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 08/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    private let movie: Movie
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "YYYY"
        return formatter
    }()
    
    //    var genres: String {
    //        return getFormattedGenres()
    //    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var numberOfSections: Int {
        return 6
    }
    
    private func getFormattedYear() -> String {
        
        guard let date = self.movie.releaseDate else { return "" }
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    } 
    
    func getTopic(for indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 1:
            return self.movie.title
        case 2:
            return self.getFormattedYear()
        case 3:
            return ""
        case 4:
            return self.movie.description
        default:
            return "Something wrong"
        }
    }
    
    private func acquireMovieGenres() {
    }
    
    //    private func getFormattedGenres() -> String {
    //
    //        var genresText = ""
    //        let moreThanOne = self.movie.genres.count >= 2
    //
    //        for genre in self.movie.genres {
    //            genresText += genre.
    //        }
    //
    //        return genresText
    //    }
    
    
}
