//
//  DefaultFavoriteMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import CoreData

class DefaultFavoriteMovieHandlerRepository: FavoriteMovieHandlerRepository {
    
    func addMovieToFavorite(_ movie: Movie, completion: @escaping (ActionResult<Error>) -> Void) {
        guard getMovie(withID: movie.id) == nil else {
            completion(.failure(CoreDataErrors.movieIsAlreadyFaved))
            return
        }

        do {
            CDMovie(movie: movie, context: CoreDataStack.persistentContainer.viewContext)
            try CoreDataStack.persistentContainer.viewContext.save()

            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func movieIsFavorite(_ movie: Movie, completion: @escaping (Result<Bool, Error>) -> Void) {
        if getMovie(withID: movie.id) != nil {
            completion(.success(true))
        } else {
            completion(.success(false))
        }
    }
    
    func removeMovieFromFavorite(movieID: Int, completion: @escaping (ActionResult<Error>) -> Void) {
        let movieRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        movieRequest.predicate = NSPredicate(format: "id == %@", String(movieID))

        do {
            guard let cdMovie = try CoreDataStack.persistentContainer.viewContext.fetch(movieRequest).first else {
                completion(.failure(CoreDataErrors.cannotFindMovieWithID(movieID)))
                return
            }
            CoreDataStack.persistentContainer.viewContext.delete(cdMovie)
            try CoreDataStack.persistentContainer.viewContext.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func getMovie(withID movieID: Int) -> Movie? {
        let movieRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        movieRequest.predicate = NSPredicate(format: "id == %@", String(movieID))

        guard let cdMovie = try? CoreDataStack.persistentContainer.viewContext.fetch(movieRequest).first else {
            return nil
        }

        return Movie(cdMovie: cdMovie)
    }
}
