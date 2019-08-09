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
}
