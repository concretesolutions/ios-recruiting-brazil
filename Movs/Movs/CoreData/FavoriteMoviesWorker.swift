//
//  FavoriteMoviesWorker
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import CoreData
import UIKit

/**
 Provides access to the CoreData and actions to do with favorite movies.
 All data about a movie are stored locally to avoid doing a request to get it
 */
class FavoriteMoviesWorker: ManageFavoriteMoviesActions {
    
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate let movieCoreData = "MovieCoreData"
    private lazy var context: NSManagedObjectContext = {
        self.appDelegate.persistentContainer.viewContext
    }()
    // Keys
    private let idKey: String = MovieDetailed.MovieCoreDataKey.id.rawValue
    private let titleKey: String =  MovieDetailed.MovieCoreDataKey.title.rawValue
    private let releaseDateKey: String = MovieDetailed.MovieCoreDataKey.releaseDate.rawValue
    private let genresKey: String = MovieDetailed.MovieCoreDataKey.genres.rawValue
    private let overviewKey: String = MovieDetailed.MovieCoreDataKey.overview.rawValue
    private let posterPathKey: String = MovieDetailed.MovieCoreDataKey.posterPath.rawValue
    private let voteAverageKey: String = MovieDetailed.MovieCoreDataKey.voteAverage.rawValue
    
    
    // MARK: - Database actions
    private func removeAll() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: movieCoreData)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("❗️ Got remove all favorites")
        }
    }
    /**
     Add a favorite movie to CoreData
     - parameter movie: all data about the movie
     */
    func addFavoriteMovie(movie: MovieDetailed) -> Bool {

        let entity = NSEntityDescription.entity(forEntityName: movieCoreData, in: context)
        let newFavorite = NSManagedObject(entity: entity!, insertInto: context)

        newFavorite.setValue(movie.id, forKey: idKey)
        newFavorite.setValue(movie.title, forKey: titleKey)
        newFavorite.setValue(movie.overview, forKey: overviewKey)
        newFavorite.setValue(movie.releaseDate, forKey: releaseDateKey)
        newFavorite.setValue(movie.genresNames, forKey: genresKey)
        newFavorite.setValue(movie.posterPath, forKey: posterPathKey)
        newFavorite.setValue(movie.voteAverage, forKey: voteAverageKey)
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func removeFavoriteMovie(id: Int) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: movieCoreData)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result  {
                let findingId = Int(data.value(forKey: idKey) as! Int)
                if findingId == id {
                    context.delete(data)
                    try context.save()
                    return true
                }
            }
        } catch {
            return false
        }
        return true
    }
    
    func getFavoriteMovies() -> [MovieDetailed] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: movieCoreData)
        request.returnsObjectsAsFaults = false
        
        var movies = [MovieDetailed]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: idKey) as! Int
                let title = data.value(forKey: titleKey) as! String
                let genres = data.value(forKey: genresKey) as! [String]
                let overview = data.value(forKey: overviewKey) as! String
                let releaseDate = data.value(forKey: releaseDateKey) as! String
                let posterPath = data.value(forKey: posterPathKey) as! String
                let voteAverage = data.value(forKey: voteAverageKey) as! Double
                
                let movie = MovieDetailed.init(id: Int(id), genres: [], genresNames: genres, title: title, overview: overview, releaseDate: releaseDate, posterPath: posterPath, voteAverage: voteAverage, isFavorite: true)
                movies.append(movie)
            }
        } catch {
            print("❗️ Got favorite movies error")
            return []
        }
        return movies
    }
    
    func findMovieWith(id: Int) -> Bool {
        let movies = getFavoriteMovies()
        let movieFound = movies.filter { $0.id == id }
        return movieFound.count == 0 ? false : true
    }

}
