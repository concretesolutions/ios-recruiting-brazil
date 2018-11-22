//
//  PopularMovieInteractor.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class DateFilterInteractor: DateFilterInteractorInput {
    
    // MARK: - Properties
    var output: DateFilterInteractorOutput!
    
    // MARK: - DateFilterInteractorInput Functions
    func getDates() {
        var dates: [Date] = []
        for movie in FavoriteMovieCoreDataManager.favoriteMovies {
            dates.append(movie.releaseDate)
        }
        
        self.output.didGetDates(dates: dates)
    }
}
