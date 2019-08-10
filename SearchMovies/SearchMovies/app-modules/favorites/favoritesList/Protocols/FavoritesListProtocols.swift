//
//  BookMarkListProtocols.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

protocol ViewToFavoritesListPresenterProtocol:class {
    var view:PresenterToFavoritesListViewProtocol?{get set}
    var iteractor:PresenterToFavoritesListIteractorProtocol?{get set}
    var route:PresenterToFavoritesListRouterProtocol?{get set}
    func loadFavorites()
    func remove(favorite:FavoritesDetailsData)
    func mapObjectFilter(favorites:[FavoritesDetailsData])
    func applyFilter(filters:[FilterReturn])
}

protocol PresenterToFavoritesListIteractorProtocol:class {
    var presenter:IteractorToFavoritesListPresenterProtocol? {get set}
    func loadFavorites()
    func remove(favorite:FavoritesDetailsData)
    func applyFilter(filters:[FilterReturn])
}

protocol PresenterToFavoritesListRouterProtocol:class {
    func pushToScreen(_ view: FavoritesListViewController, segue: String, param:AnyObject?)
}

protocol IteractorToFavoritesListPresenterProtocol:class {
    func returnFavorites(favorites:[FavoritesDetailsData])
    func returnFavoritesError(message:String)
    func returnRemoveFavorites()
    func returnRemoveFavoritesError(message:String)
    func returnApplyFilter(favorites:[FavoritesDetailsData])
}

protocol PresenterToFavoritesListViewProtocol:class {
    func returnFavorites(favorites:[FavoritesDetailsData])
    func returnFavoritesError(message:String)
    func returnRemoveFavorites()
    func returnRemoveFavoritesError(message:String)
    func returnMapObjectFilter(filter:[FilterSelectData])
    func returnApplyFilter(favorites:[FavoritesDetailsData])
}
