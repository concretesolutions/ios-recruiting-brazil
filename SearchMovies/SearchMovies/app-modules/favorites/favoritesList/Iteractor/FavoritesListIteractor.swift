//
//  FavoritesListIteractor.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FavoritesListIteractor: PresenterToFavoritesListIteractorProtocol {
    var presenter: IteractorToFavoritesListPresenterProtocol?
    let repository:FavoritesRepository = FavoritesRepository()
    func loadFavorites() {
        let favorites:[FavoritesDetailsData] = repository.loadFavorites(predicate: nil)
        self.presenter?.returnFavorites(favorites: favorites)
    }
    
    func remove(favorite: FavoritesDetailsData) {
        repository.remove(favorites: favorite)
        self.presenter?.returnRemoveFavorites()
    }
    
    func applyFilter(filters: [FilterReturn]) {
        var predicate:NSPredicate? = nil
        var favorites:[FavoritesDetailsData]?
        if filters.count == 1 {
            
            switch filters.first?.filterName {
            case "year":
                predicate = NSPredicate(format: "year == %d", Int((filters.first?.filterValue)!)!)
            case "genres":
                predicate = NSPredicate(format: "genres contains[c] %@", (filters.first?.filterValue)!)
            default:
                break
            }
            
            
        }
        else {
            switch filters.first?.filterName {
            case "year":
                predicate = NSPredicate(format: "year == %d && genres contains[c] %@", Int((filters.first?.filterValue)!)!, filters[1].filterValue)
            case "genres":
                predicate = NSPredicate(format: "genres contains[c] %@ && year == %d", (filters.first?.filterValue)!, Int(filters[1].filterValue)! )
            default:
                break
            }
           
        }
        favorites = repository.loadFavorites(predicate: predicate)
       
        self.presenter?.returnApplyFilter(favorites: favorites!)
    }
}
