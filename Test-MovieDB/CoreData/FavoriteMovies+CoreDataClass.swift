//
//  FavoriteMovies+CoreDataClass.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(FavoriteMovies)
public class FavoriteMovies: NSManagedObject {
    
    var fetchedResultsController: NSFetchedResultsController<FavoriteMovies>!
    var fetchRequest: NSFetchRequest<FavoriteMovies>!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favorite: Favorite!
    
    func fetch() {
        let request = FavoriteMovies.fetchRequest() as NSFetchRequest<FavoriteMovies>
        let sort = NSSortDescriptor(keyPath: \FavoriteMovies.title, ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedResultsController.performFetch()
            fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        } catch let error as NSError {
            print("porra de erro \(error.localizedDescription)")
        }
    }
    
    func save(movie: FavoriteMovies) {
        let saveMovie = FavoriteMovies(entity: FavoriteMovies.entity(), insertInto: context)
        saveMovie.title = movie.title
        saveMovie.movieDescription = movie.description
        saveMovie.posterPath = movie.posterPath
        saveMovie.isFavorite = movie.isFavorite
        saveMovie.genreID = movie.genreID
        saveMovie.yearOfRelease = movie.yearOfRelease
        saveMovie.id = movie.id
        appDelegate.saveContext()
    }
    
    func removeFavorite(movie: FavoriteMovies) {
        context.delete(movie)
        fetch()
        appDelegate.saveContext()
    }
    
    func savingFavorite(movie: Favorite) {
        let saveMovie = FavoriteMovies(entity: FavoriteMovies.entity(), insertInto: context)
        saveMovie.title = movie.title
        saveMovie.movieDescription = movie.description
        saveMovie.posterPath = movie.posterPath
        saveMovie.isFavorite = movie.isFavorite
        saveMovie.genreID = movie.genreID
        saveMovie.yearOfRelease = movie.yearOfRelease
        saveMovie.id = Int64(movie.id)
        appDelegate.saveContext()
    }
    
    func filteringData(movieID: Int) {
        let request = FavoriteMovies.fetchRequest() as NSFetchRequest<FavoriteMovies>
        let sort = NSSortDescriptor(keyPath: \FavoriteMovies.id, ascending: true)
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "id == %@", "\(movieID)")
        do {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("porra de erro \(error.localizedDescription)")
        }
    }
}

