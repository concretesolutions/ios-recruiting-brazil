//
//  MovieDataBase.swift
//  GPSMovies
//
//  Created by Gilson Santos on 04/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import CoreData

class MovieDataBase {
    private var fetchRequest:NSFetchRequest<MovieDB> = MovieDB.fetchRequest()
}

extension MovieDataBase {
    
    public func createOrRemoveMovieDataBase(model: MovieElementModel){
        guard let id = model.id else { return }
        if let movieResult = self.getMovieById(id: id){
            self.removeMovieDataBase(movieResult)
        }else{
            
            //create DB
        }
    }
    
    public func fetchMoviesDataBase() -> [MovieDB]?{
        return self.getMovieList()
    }
    
    private func getMovieById(id: Int64) -> MovieDB?{
        self.fetchRequest.predicate = NSPredicate(format: "id == %@", String(describing: id))
        do {
            let result = try PersistentManager.shared.context.fetch(self.fetchRequest)
            if let movieDb = result.first{
                return movieDb
            }
        } catch {
            return nil
        }
        return nil
    }
    
    private func getMovieList() -> [MovieDB]?{
        do {
            return try PersistentManager.shared.context.fetch(self.fetchRequest)
        } catch {
            return nil
        }
    }
    
    private func removeMovieDataBase(_ dataBase: MovieDB){
        PersistentManager.shared.context.delete(dataBase)
        PersistentManager.shared.saveContext()
    }
    
}




