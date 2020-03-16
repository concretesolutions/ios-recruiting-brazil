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
    private var favMovies: [FavoriteMovie] = []
    private var isFetchInProgress = false
    
    public var currentCount: Int {
        return favMovies.count
    }
        
    // MARK: - Class Functions
    
    public func movie(at index: Int) -> FavoriteMovie {
        return favMovies[index]
    }
    
    public func getMovies() -> [FavoriteMovie] {
        return favMovies
    }
    
    public func fetchFavorites() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        do {
            let dataManager = PersistanceManager()
            favMovies = try dataManager.fetchFavoritesList()
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.delegate?.onFetchCompleted()
            }
        } catch {
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: "Erro ao carregar favoritos")
            }
        }
    }
    
    public func deleteFavorite(line: Int, completion: @escaping(_ result: Bool) -> Void) {
        let managedObjCont = PersistanceService.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        let lineToDelete = favMovies[line].id
        let predicate = NSPredicate(format: "id == %d", lineToDelete)
        fetchRequest.predicate = predicate
        var didDeleted = false
        do {
            let items = try managedObjCont.fetch(fetchRequest) as! [FavoriteMovie]
            for item in items {
                managedObjCont.delete(item)
                didDeleted = true
            }
            favMovies.remove(at: line)
            PersistanceService.saveContext()
            completion(didDeleted)
        } catch {
            completion(false)
        }
    }


}
