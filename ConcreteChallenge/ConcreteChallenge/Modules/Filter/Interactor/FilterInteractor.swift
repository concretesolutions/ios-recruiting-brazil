//
//  PopularMovieInteractor.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class FilterInteractor: FilterInteractorInput {
    
    // MARK: - Properties
    var output: FilterInteractorOutput!
    
    // MARK: - FilterInteractorInput Functions
    func getDateFilter() {
        self.output.didGetDateFilter(dates: FavoriteMovieCoreDataManager.datesFilter)
    }
    
    func getGenreFilter() {
        self.output.didGetGenreFilter(genres: FavoriteMovieCoreDataManager.genresFilter)
    }
}
