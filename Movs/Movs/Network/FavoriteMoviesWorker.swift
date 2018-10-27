//
//  FavoriteMoviesWorker
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import CoreData
import UIKit


class FavoriteMoviesWorker {
    
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
    
    func addFavoriteMovie(movie: MovieDetailed) {
        
        let entity = NSEntityDescription.entity(forEntityName: movieCoreData, in: context)
        let newFavorite = NSManagedObject(entity: entity!, insertInto: context)
 
        newFavorite.setValue(movie.id, forKey: idKey)
        newFavorite.setValue(movie.title, forKey: titleKey)
        newFavorite.setValue(["aaaa", "bbb", "cccc"], forKey: genresKey)
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getFavoriteMovies() -> [MovieDetailed] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: movieCoreData)
        request.returnsObjectsAsFaults = false
        
        var movies = [MovieDetailed]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: idKey) as! Int16
                let title = data.value(forKey: titleKey) as! String
                let genres = data.value(forKey: genresKey) as! [String]
                
                print("🦑 getting data from Core Manager")
                print(id)
                print(title)
                print(genres.description)
            }
        } catch {
            print("Failed")
        }
        return []  
    }
    
}
