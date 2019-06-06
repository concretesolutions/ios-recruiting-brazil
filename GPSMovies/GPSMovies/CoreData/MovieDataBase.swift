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
            self.parseModelFromDataBase(model: model)
        }
    }
    
    public func fetchMoviesDataBase() -> [MovieElementModel]?{
        if let movieListDB = self.getMovieList(), movieListDB.count > 0 {
            return self.parseDataBaseFromModel(moviesDB: movieListDB)
        }
        return nil
    }
    
    public func isFavoriteMovie(idMovie: Int64) -> Bool {
        return self.getMovieById(id: idMovie) == nil
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

extension MovieDataBase {
    
    private func parseModelFromDataBase(model: MovieElementModel) {
        guard let id = model.id else { return }
        let genreDataBase = GenreDataBase()
        let movieDB = MovieDB(context: PersistentManager.shared.context)
        movieDB.id = id
        movieDB.title = model.title
        movieDB.coverPath = model.backdropPath
        movieDB.posterPath = model.posterPath
        movieDB.overview = model.overview
        movieDB.rating = model.voteAverage ?? 0.0
        movieDB.relaseDate = model.releaseDate
        if let genreIds = model.genreIds, genreIds.count > 0 {
            genreIds.forEach { (genreIdRow) in
                if let genreDB = genreDataBase.fetchGenreDataBaseById(id: genreIdRow) {
                    movieDB.addToGenres(genreDB)
                }
            }
        }
        PersistentManager.shared.saveContext()
    }
    
    private func parseDataBaseFromModel(moviesDB: [MovieDB]) -> [MovieElementModel] {
        var moviesModelList = [MovieElementModel]()
        moviesDB.forEach { (movieRow) in
            let movieModel = MovieElementModel()
            movieModel.id = movieRow.id
            movieModel.title = movieRow.title
            movieModel.backdropPath = movieRow.coverPath
            movieModel.posterPath = movieRow.posterPath
            movieModel.overview = movieRow.overview
            movieModel.voteAverage = movieRow.rating
            movieModel.releaseDate = movieRow.relaseDate
            moviesModelList.append(movieModel)
        }
        return moviesModelList
    }
}




