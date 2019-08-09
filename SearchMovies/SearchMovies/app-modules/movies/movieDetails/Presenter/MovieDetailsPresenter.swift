//
//  MovieDetailsPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieDetailsPresenter: ViewToMovieDetailsPresenterProtocol {
    weak var view: PresenterToMovieDetailsViewProtocol?
    
    var iteractor: PresenterToMovieDetailsIteractorProtocol?
    
    var route: PresenterToMovieDetailsRouterProtocol?
    
    func loadGenerNames(ids: [Int]) {
        let genders:[String] = (SingletonProperties.shared.genres?.map({ (result) -> String in
            return result.name
        }))!
        
        self.view?.returnloadGenerNames(genders: genders)
    }
    
    func loadMovieDetails(id: Int) {
        self.iteractor?.loadMovieDetails(id: id)
    }
}

extension MovieDetailsPresenter : IteractorToMovieDetailsPresenterProtocol {
    func returnMovieDetails(details: MovieDetailsData) {
       
        self.iteractor?.loadMovieReleaseDates(id: details.id)
       
    }
    
    func returnMovieDetailsError(messageError: String) {
        self.view?.returnMovieDetailsError(messageError: messageError)
    }
    
    func returnDateRelease(releaseDate: ReleaseDateList) {
        let release:[DataReleaseDate] = releaseDate.resultsRelease.map { (item) -> DataReleaseDate in
            return item.releases.first!
        }
        
        
        
    }
    
    func returnDateReleaseError(messageError: String) {
        
    }
    
    
}
    

