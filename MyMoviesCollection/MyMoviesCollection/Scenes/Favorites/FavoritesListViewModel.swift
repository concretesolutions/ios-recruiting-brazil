//
//  FavoritesListViewModel.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 15/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation
import CoreData

protocol FavoritesListViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

final class FavoritesListViewModel {
    
    // MARK: - Initializer
    
    init(delegate: FavoritesListViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Properties
    
    private weak var delegate: FavoritesListViewModelDelegate?
    private var movies: [FavoriteMovie] = []
   // private var isFetchInProgress = false
        
    // MARK: - Class Functions
    
    public func getMovies() -> [FavoriteMovie] {
        return movies
    }
    
    public func fetchFavorites() {
        //guard !isFetchInProgress else {
//            return
        //}
        //isFetchInProgress = true
        let managedObjCont = PersistanceService.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        do {
            //let favMovies = try (managedObjCont.fetch(fetchRequest) as! [FavoriteMovie])
            //movies = favMovies
            //print(favMovies)
        } catch {
            //let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            //displayAlert(with: "Alerta", message: "Erro ao buscar favoritos!", actions: [action])
        }


    }


}
