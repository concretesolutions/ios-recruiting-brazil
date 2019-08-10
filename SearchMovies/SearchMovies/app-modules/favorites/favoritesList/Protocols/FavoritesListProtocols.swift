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
   
}

protocol PresenterToFavoritesListIteractorProtocol:class {
    var presenter:IteractorToFavoritesListPresenterProtocol? {get set}
    func loadFavorites()
}

protocol PresenterToFavoritesListRouterProtocol:class {
    func pushToScreen(_ view: FavoritesListViewController, segue: String, param:AnyObject?)
}

protocol IteractorToFavoritesListPresenterProtocol:class {
    func returnFavorites(favorites:[FavoritesDetailsData])
    func returnFavoritesError(message:String)
  
}

protocol PresenterToFavoritesListViewProtocol:class {
    func returnFavorites(favorites:[FavoritesDetailsData])
    func returnFavoritesError(message:String)
}
