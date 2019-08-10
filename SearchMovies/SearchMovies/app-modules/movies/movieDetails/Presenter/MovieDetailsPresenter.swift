//
//  MovieDetailsPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieDetailsPresenter: ViewToMovieDetailsPresenterProtocol {
    //MARK: Properties
    weak var view: PresenterToMovieDetailsViewProtocol?
    var iteractor: PresenterToMovieDetailsIteractorProtocol?
    var route: PresenterToMovieDetailsRouterProtocol?
    //MARK: Functions
    func loadGenerNames(ids: [Int]) {
        var genders:[String] = (SingletonProperties.shared.genres?.map({ (result) -> String in
            if ids.contains(result.id) {
                return result.name
            }
            else {
                return ""
            }
        }))!
        
        genders = genders.removeDuplicates()
        genders.removeAll { (result) -> Bool in
            return result == ""
        }
        
        
        self.view?.returnloadGenerNames(genders: genders.removeDuplicates())
    }
    
    func loadMovieDetails(id: Int) {
        self.iteractor?.loadMovieDetails(id: id)
    }
    
    func loadMovieReleaseDates(id: Int) {
        self.iteractor?.loadMovieReleaseDates(id: id)
    }
    
    func actionInFavoriteMovie(isFavorite: Bool, favoriteMovie: FavoritesDetailsData) {
        self.iteractor?.actionInFavoriteMovie(isFavorite: isFavorite, favoriteMovie: favoriteMovie)
    }
}

extension MovieDetailsPresenter : IteractorToMovieDetailsPresenterProtocol {
    func returnActionInFavoriteMovie(isFavorite: Bool) {
        self.view?.returnActionInFavoriteMovie(isFavorite: isFavorite)
    }
    
    func returnMovieDetails(details: MovieDetailsData) {
        self.view?.returnMovieDetails(details: details)
    }
    
    func returnMovieDetailsError(messageError: String) {
        self.view?.returnMovieDetailsError(messageError: messageError)
    }
    
    func returnDateRelease(releaseDate: ReleaseDateList) {
        let release:[DataReleaseDate] = releaseDate.resultsRelease.map { (item) -> DataReleaseDate in
            return item.releases.first!
        }
        
        self.view?.returnDateRelease(releaseDate: release.first!)
    }
    
    func returnDateReleaseError(messageError: String) {
       
    }
}
    

