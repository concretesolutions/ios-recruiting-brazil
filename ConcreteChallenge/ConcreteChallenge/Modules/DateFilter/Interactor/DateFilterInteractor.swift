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
        // Get only the dates from the favorite movies
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
        
        // Sort Array
        noRepeatedDates = noRepeatedDates.sorted { (date1, date2) -> Bool in
            var sort = true
            
            if let dateYear1 = date1.year, let dateYear2 = date2.year {
                if dateYear1 > dateYear2 {
                    sort = false
                }
            }
            return sort
        }
        
        self.output.didGetDates(dates: noRepeatedDates)
    }
    
    func saveDateFilter(dates: [Date]) {
        FavoriteMovieCoreDataManager.datesFilter = dates
    }
}
