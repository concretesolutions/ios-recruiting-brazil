//
//  MovieDetailViewModel.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 14/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation
import CoreData

protocol MovieDetailViewModelDelegate: class {
    func fetchGenresCompleted()
    func fetchGenresFailed(with reason: String)
}

final class MovieDetailViewModel {
    
    // MARK: - Initializer
    
    init(delegate: MovieDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Properties
    
    private weak var delegate: MovieDetailViewModelDelegate?
    private var genres: [Genres] = []
    private var genresAppended: String = ""
    private var isFetchInProgress = false
    
    let client = MoviesAPIClient()
    
    // MARK: - Class Functions
    
    public func getGenres() -> [Genres] {
        return genres
    }
    
    public func fetchMovieDetail() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        client.fetchMoviesGenres() { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.fetchGenresFailed(with: error.reason)
                }
            case .success(let response):
                self.isFetchInProgress = false
                DispatchQueue.main.async {
                    self.genres = response.genres
                    self.isFetchInProgress = false
                    self.delegate?.fetchGenresCompleted()
                }
            }
        }
    }
    
    public func findGens(genIds: [Int?]) -> String {
        var finalGenString = ""
        for i in 0..<genIds.count {
            finalGenString.append(contentsOf: getGenById(from: genIds[i] ?? 0))
            if i != (genIds.count - 1) {
                finalGenString.append(contentsOf: ", ")
            }
        }
        return finalGenString
    }
    
    private func getGenById(from id: Int) -> String {
        for index in 0..<genres.count  {
            if genres[index].id == id {
                return genres[index].name
            }
        }
        return ""
    }
    
    public func favoriteMovie(movie: Movie, completion: @escaping(_ saved: Bool) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: PersistanceService.context) else {
            completion(false)
            return
        }
        let movieToPersist = NSManagedObject(entity: entity, insertInto: PersistanceService.context)
        movieToPersist.setValue(movie.title, forKey: "title")
        movieToPersist.setValue(movie.overview, forKey: "overview")
        movieToPersist.setValue(movie.releaseDate, forKey: "year")
        movieToPersist.setValue(movie.posterUrl, forKey: "posterUrl")
        if let idToSave = movie.id {
            movieToPersist.setValue(idToSave, forKey: "id")
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
        fetchRequest.includesPropertyValues = false
        
        PersistanceService.saveContext()
        completion(true)
        
    }
    
    public func checkIfFavorite(id: Int32, completion: @escaping(_ result: Bool) -> Void) {
        let managedObjCont = PersistanceService.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        do {
            let result = try managedObjCont.fetch(fetchRequest)
            if result.count > 0 {
                completion(true)
            } else {
                completion(false)
            }
        } catch {
            completion(false)
        }
    }
    
}
