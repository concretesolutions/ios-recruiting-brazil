//
//  MovieDetailsProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToMovieDetailsPresenterProtocol:class {
    var view:PresenterToMovieDetailsViewProtocol?{get set}
    var iteractor:PresenterToMovieDetailsIteractorProtocol?{get set}
    var route:PresenterToMovieDetailsRouterProtocol?{get set}
    func loadGenerNames(ids:[Int])
    func loadMovieDetails(id:Int)
    func loadMovieReleaseDates(id:Int)
    func actionInFavoriteMovie(isFavorite:Bool, favoriteMovie:FavoritesDetailsData)
}

protocol PresenterToMovieDetailsIteractorProtocol:class {
    var presenter:IteractorToMovieDetailsPresenterProtocol? {get set}
    func loadMovieDetails(id:Int)
    func loadMovieReleaseDates(id:Int)
    func actionInFavoriteMovie(isFavorite:Bool, favoriteMovie:FavoritesDetailsData)
}

protocol PresenterToMovieDetailsRouterProtocol:class {
    func pushToScreen(_ view: MovieDetailsViewController, segue: String)
    func dismiss(_ view: MovieDetailsViewController, animated:Bool)
}

protocol IteractorToMovieDetailsPresenterProtocol:class {
    func returnMovieDetails(details:MovieDetailsData)
    func returnMovieDetailsError(messageError:String)
    func returnDateRelease(releaseDate:ReleaseDateList)
    func returnDateReleaseError(messageError:String)
    func returnActionInFavoriteMovie(isFavorite:Bool)
}

protocol PresenterToMovieDetailsViewProtocol:class {
    func returnloadGenerNames(genders:[String])
    func returnMovieDetails(details:MovieDetailsData)
    func returnMovieDetailsError(messageError:String)
    func returnDateRelease(releaseDate:DataReleaseDate)
    func returnDateReleaseError(messageError:String)
    func returnActionInFavoriteMovie(isFavorite:Bool)
}
