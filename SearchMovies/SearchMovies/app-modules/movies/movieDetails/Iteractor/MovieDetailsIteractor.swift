//
//  MovieDetailsIteractor.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieDetailsIteractor: PresenterToMovieDetailsIteractorProtocol {
  
    var presenter: IteractorToMovieDetailsPresenterProtocol?
    let service:MovieDetailsService = MovieDetailsService()
    
    func loadMovieDetails(id: Int) {
        
        if !Reachability.isConnectedToNetwork() {
            self.presenter?.returnMovieDetailsError(messageError: Constants.defaultMessageError)
            return
        }
        
        service.getMovieDetail(appKey: Constants.appKey, id: id) { (result) in
            if result.typeReturnService == .success {
                let objectReturn:MovieDetailsData = result.objectReturn as! MovieDetailsData
                self.presenter?.returnMovieDetails(details: objectReturn)
            }
            else {
                self.presenter?.returnMovieDetailsError(messageError: result.messageReturn!)
            }
        }
    }
    
    func loadMovieReleaseDates(id: Int) {
        
        if !Reachability.isConnectedToNetwork() {
            self.presenter?.returnDateReleaseError(messageError: Constants.defaultMessageError)
            return
        }
        
        service.getMovieDetailReleaseDate(appKey: Constants.appKey, id: id) { (result) in
            if result.typeReturnService == .success {
                let objectReturn:ReleaseDateList = result.objectReturn as! ReleaseDateList
                self.presenter?.returnDateRelease(releaseDate: objectReturn)
            }
            else {
                self.presenter?.returnDateReleaseError(messageError: result.messageReturn!)
            }
        }
    }
    
    func actionInFavoriteMovie(isFavorite: Bool, favoriteMovie:FavoritesDetailsData) {
        let repositoryFavorite:FavoritesRepository = FavoritesRepository()
        let favoriteList:[FavoritesDetailsData] = repositoryFavorite.loadFavorites(predicate: nil)
        if favoriteList.count == 0 {
            //save favorite movie
            let result = repositoryFavorite.save(favorites: favoriteMovie)
            self.presenter?.returnActionInFavoriteMovie(isFavorite: result)
            return
        }
        
        let isExists:Bool = favoriteList.contains(where: { favorite in favorite.id == favoriteMovie.id })
        
        if isExists {
            //remove
            repositoryFavorite.remove(favorites: favoriteMovie)
        }
        else {
            //save
            let result = repositoryFavorite.save(favorites: favoriteMovie)
            self.presenter?.returnActionInFavoriteMovie(isFavorite: result)
        }
    }
}
