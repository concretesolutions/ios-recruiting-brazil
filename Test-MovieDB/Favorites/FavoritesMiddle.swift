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
    private var favoritesFetched: [FavoriteMovies] = []
    weak var delegate: FavoriteMoviesMiddleDelegate?
    
    var quantityOfFavorites: Int {
        return favoritesFetched.count
    }
    
    var favorites: [FavoriteMovies] {
        return favoritesFetched
    }
    
    init(delegate: FavoriteMoviesMiddleDelegate) {
        self.delegate = delegate
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        self.fetchFavorites()
    }
    
    func movieData(at index: Int) -> FavoriteMovies {
        return favorites[index]
    }
    
    func filterByPeriodAndGenre(genre: Int?, period: Int?) {
        let request = FavoriteMovies.fetchRequest() as NSFetchRequest<FavoriteMovies>
        let sort = NSSortDescriptor(keyPath: \FavoriteMovies.title, ascending: true)
        request.sortDescriptors = [sort]
        
        if genre == nil && period != nil {
            guard let newPeriod = period else { return }
            let predicate = NSPredicate(format: "yearOfRelease = %@", String(newPeriod))
            request.predicate = predicate
            
        } else if period == nil && genre != nil {
            guard let newGenre = genre else { return }
            let predicate = NSPredicate(format: "id = %i", newGenre)
            request.predicate = predicate
            
        } else if period != nil && genre != nil {
            if let predGenre = genre, let predPedio = period {
                let genrePredicate = NSPredicate(format: "id = %i", predGenre)
                let periodPredicate = NSPredicate(format: "yearOfRelease = %@", String(predPedio))
                let predicates = NSCompoundPredicate(type: .and, subpredicates: [genrePredicate, periodPredicate])
                request.predicate = predicates
            }
        }

        do {
            favoriteMovies.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: favoriteMovies.context, sectionNameKeyPath: nil, cacheName: nil)
            try favoriteMovies.fetchedResultsController.performFetch()
            favoritesFetched = favoriteMovies.fetchedResultsController.fetchedObjects ?? []
            delegate?.favoritesFetched()
        } catch let error as NSError {
            print(error.description)
        }
        
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
