//
//  FavoriteMoviesManager.swift
//  theMovie-app
//
//  Created by Adriel Alves on 08/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Kingfisher



class FavoriteMoviesManager: FavoriteMoviesManagerProtocol {
    
    private var fetchedResultController: NSFetchedResultsController<FavoriteMovieData>!
    
    var context: NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    func fetchById(index: Int64) -> [FavoriteMovieData]? {
        
        let fetchRequest: NSFetchRequest<FavoriteMovieData> = FavoriteMovieData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "movieTitle", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(index))
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fetch(filtering: String = "") -> [FavoriteMovieData]? {
        let fetchRequest: NSFetchRequest<FavoriteMovieData> = FavoriteMovieData.fetchRequest()
        let titleDescriptor = NSSortDescriptor(key: "movieTitle", ascending: true)
        let yearDescriptor = NSSortDescriptor(key: "movieYear", ascending: true)
        if !filtering.isEmpty {
            let predicate = NSPredicate(format: "movieTitle contains [c] %@", filtering)
            fetchRequest.predicate = predicate
        }
        fetchRequest.sortDescriptors = [titleDescriptor, yearDescriptor]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func addFavoriteMovie(favoriteMovieData: FavoriteMovieData) {
        
        do {
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func addFavoriteMovie(movieVM: MovieViewModel) {
        
        let favoriteMovie = FavoriteMovieData(context: context)
        let moviePoster: UIImageView = UIImageView()
        moviePoster.kf.setImage(with: movieVM.posterPath)
        favoriteMovie.movieTitle = movieVM.title
        favoriteMovie.movieYear = movieVM.year
        favoriteMovie.movieDetails = movieVM.overview
        favoriteMovie.moviePoster = moviePoster.image
        favoriteMovie.id = movieVM.id
        
        do {
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func delete(id: Int64) {
        
        guard let favoriteMoviesData = fetch(filtering: "") else { return }
        
        for favoriteMovie in favoriteMoviesData {
            if id == favoriteMovie.id {
                context.delete(favoriteMovie)
            }
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
