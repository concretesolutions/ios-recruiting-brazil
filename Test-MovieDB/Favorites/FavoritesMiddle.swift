//
//  FavoritesMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol FavoriteMoviesMiddleDelegate: class {
    func favoritesFetched()
    func savedMovie()
    func deletedMovie()
}

class FavoriteMoviesMiddle {
    
    let favoriteMovies = FavoriteMovies()
    var favoritesFetched: [FavoriteMovies] = []
    weak var delegate: FavoriteMoviesMiddleDelegate?
    
    init(delegate: FavoriteMoviesMiddleDelegate) {
        self.delegate = delegate
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        self.fetchFavorites()
    }
    
    func movieData(at index: Int) -> FavoriteMovies {
        return favoritesFetched[index]
    }
    
    func filteringData(searchString: String) {
        let request = FavoriteMovies.fetchRequest() as NSFetchRequest<FavoriteMovies>
        let sort = NSSortDescriptor(keyPath: \FavoriteMovies.title, ascending: true)
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchString)
        do {
            favoriteMovies.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: favoriteMovies.context, sectionNameKeyPath: nil, cacheName: nil)
            try favoriteMovies.fetchedResultsController.performFetch()
            favoritesFetched = favoriteMovies.fetchedResultsController.fetchedObjects ?? []
            delegate?.favoritesFetched()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func fetchFavorites() {
        favoriteMovies.fetch()
        favoritesFetched = favoriteMovies.fetchedResultsController.fetchedObjects ?? []
        delegate?.favoritesFetched()
    }
    
    func save(movie: FavoriteMovies) {
        favoriteMovies.save(movie: movie)
        delegate?.savedMovie()
    }
    
    func delete(movie: FavoriteMovies) {
        favoriteMovies.removeFavorite(movie: movie)
        delegate?.deletedMovie()
    }
}
