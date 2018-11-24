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
        // Get all dates
        var dates: [Date] = []
        for movie in FavoriteMovieCoreDataManager.favoriteMovies {
            dates.append(movie.releaseDate)
        }
        
        // Remove repeated dates with years
        var noRepeatedDates: [Date] = []
        var shouldAdd = true
        for date in dates {
            for noRepeatedDate in noRepeatedDates {
                if noRepeatedDate.year == date.year {
                    shouldAdd = false
                }
            }
            if shouldAdd {
                noRepeatedDates.append(date)
            }
            shouldAdd = true
        }
        
        self.output.didGetDates(dates: noRepeatedDates)
    }
}
