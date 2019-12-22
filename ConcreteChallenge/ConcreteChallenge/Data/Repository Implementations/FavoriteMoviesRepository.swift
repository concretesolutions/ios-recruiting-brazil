//
//  FavoriteMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import CoreData

class FavoriteMoviesRepository: MoviesRepository {
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void) {
        guard page == 1 else {
            completion(.success(Page<Movie>()))
            return
        }
        
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
}
