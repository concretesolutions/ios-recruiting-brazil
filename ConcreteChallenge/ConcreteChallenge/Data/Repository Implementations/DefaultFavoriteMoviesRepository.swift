//
//  DefaultFavoriteMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import CoreData

class DefaultFavoriteMoviesRepository: FavoriteMoviesRepository {
    
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void) {
        let movieRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()

        do {
            let cdMovies = try CoreDataStack.persistentContainer.viewContext.fetch(movieRequest)

            completion(.success(Page<Movie>(items: cdMovies.map({ (cdMovie) -> Movie in
                return Movie(cdMovie: cdMovie)
            }))))
        } catch {
            completion(.failure(error))
        }
    }
    
    func addMovieToFavorite(_ movie: Movie, completion: @escaping (ActionResult<Error>) -> Void) {
        guard getMovie(withID: String(movie.id)) == nil else {
            completion(.failure(CoreDataErrors.movieIsAlreadyFaved))
            return
        }

        do {
            CDMovie(movie: movie)
            try CoreDataStack.persistentContainer.viewContext.save()

            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    private func getMovie(withID movieID: String) -> Movie? {
        let movieRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        movieRequest.predicate = NSPredicate(format: "id == %@", movieID)

        guard let cdMovie = try? CoreDataStack.persistentContainer.viewContext.fetch(movieRequest).first else {
            return nil
        }

        return Movie(cdMovie: cdMovie)
    }
     
    func removeMovieFromFavorite(movieID: Int, completion: @escaping (ActionResult<Error>) -> Void) {
        let movieRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        movieRequest.predicate = NSPredicate(format: "id == %@", movieID)

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
}
