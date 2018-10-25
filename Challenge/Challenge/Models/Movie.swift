//
//  Movie.swift
//  Challenge
//
//  Created by Sávio Berdine on 20/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreData
import Kingfisher

class Movie {
    
    var imagePath: String?
    var name: String?
    var isFavourite: Bool?
    var date: String?
    var genre: Observable<String> = Observable<String>(value: "")
    var description: String?
    var overview: String?
    var id: Int?
    var image: UIImage = UIImage()
    
    init() {
        
    }
    
    init(coredataObject: NSManagedObject) {
        self.imagePath = ""
        if let name = coredataObject.value(forKey: "title") {
            self.name = (name as! String)
        } else {
            self.name = ""
        }
        if let genre = coredataObject.value(forKey: "genre") {
            self.genre.update(with: genre as! String)
        } else {
            self.genre.update(with: "")
        }
        if let date = coredataObject.value(forKey: "date") {
            self.date = (date as! String)
        } else {
            self.name = ""
        }
        if let overview = coredataObject.value(forKey: "overview") {
            self.overview = (overview as! String)
        } else {
            self.overview = ""
        }
        if let id = coredataObject.value(forKey: "id") {
            self.id = (id as! Int)
        } else {
            self.id = 0
        }
        if let image = coredataObject.value(forKey: "image") {
            self.image = UIImage(data: image as! Data) ?? UIImage()
        }
        self.isFavourite = true
        self.description = ""
    }
    
    init(movie: [String: Any]) {
        //self.image = movie["image"]
        if let dbName = movie["title"] as? String {
            self.name = dbName
        } else {
            self.name = ""
        }
        //self.isFavourite = isFavourite
        if let dbDate = movie["release_date"] as? String {
            self.date = dbDate
        } else {
            self.date = ""
        }
        self.genre.update(with: "")
        if let genreIds = movie["genre_ids"] as? [Int] {
            if Genre.currentGenres.isEmpty {
                Genre.getCurrentGenres(onSuccess: { (genreArray) in
                    Genre.currentGenres = genreArray
                    for element in genreIds {
                        let localGenre = Genre.currentGenres.first {$0.id == element}
                        if localGenre != nil {
                            if !(self.genre.read().isEmpty) {
                                self.genre.update(with: "\(String(describing: self.genre.read())), \(String(describing: (localGenre?.name!)!))")
                            } else {
                                self.genre.update(with: "\(String(describing: (localGenre?.name!)!))")
                            }
                        }
                    }
                }) { (error) in
                    print("Error fetching genres: \(error)")
                }
            } else {
                for element in genreIds {
                    let localGenre = Genre.currentGenres.first {$0.id == element}
                    if localGenre != nil {
                        if !(self.genre.read().isEmpty) {
                            self.genre.update(with: "\(String(describing: self.genre.read())), \(String(describing: (localGenre?.name!)!))")
                        } else {
                            self.genre.update(with: "\(String(describing: (localGenre?.name!)!))")
                        }
                    }
                }
            }
        } else {
            self.genre.update(with: "")
        }
        if let dbOverview = movie["overview"] as? String {
            self.overview = dbOverview
        } else {
            self.overview = ""
        }
        self.description = ""
        if let dbId = movie["id"] as? Int {
            self.id = dbId
        } else {
            self.id = 0
        }
        if let dbImagePath = movie["poster_path"] as? String {
            self.imagePath = dbImagePath
        } else {
            self.imagePath = ""
        }
    }
    
    class func loadCoreData() -> (NSEntityDescription, NSManagedObjectContext)? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        if let movieEntity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext) {
            return (movieEntity, managedContext)
        } else {
            return nil
        }
    }
    
    class func fetchSortedByGenre() -> [Movie]{
        
        guard let coreDataData = self.loadCoreData() else {
            return []
        }
        //let entity = coreDataData.0
        let managedContext = coreDataData.1
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        
        let descriptor = NSSortDescriptor(key: "genre", ascending: true)
        
        fetchRequest.sortDescriptors = [descriptor]
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            print("Fetch Successfull.")
            var returnMovies: [Movie] = []
            for object in objects {
                let movie = Movie(coredataObject: object)
                returnMovies.append(movie)
            }
            return returnMovies
        } catch let error as NSError {
            print("Could not Fetch. \(error) \(error.userInfo)")
            return []
        }
        
    }
    
    class func fetchSortedByDate() -> [Movie]{
        
        guard let coreDataData = Movie.loadCoreData() else {
            return []
        }
        //let entity = coreDataData.0
        let managedContext = coreDataData.1
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        
        let descriptor = NSSortDescriptor(key: "date", ascending: true)
        
        fetchRequest.sortDescriptors = [descriptor]
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            print("Fetch Successfull.")
            var returnMovies: [Movie] = []
            for object in objects {
                let movie = Movie(coredataObject: object)
                returnMovies.append(movie)
            }
            return returnMovies
        } catch let error as NSError {
            print("Could not Fetch. \(error) \(error.userInfo)")
            return []
        }
    }
    
    class func fetch() -> [NSManagedObject] {
        guard let coreDataData = Movie.loadCoreData() else {
            return []
        }
        //let entity = coreDataData.0
        let managedContext = coreDataData.1
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        
        let descriptor = NSSortDescriptor(key: "date", ascending: true)
        
        fetchRequest.sortDescriptors = [descriptor]
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            print("Fetch Successfull.")
            return objects
        } catch let error as NSError {
            print("Could not Fetch. \(error) \(error.userInfo)")
            return []
        }
    }
    
    class func saveMoviesToCoreData(movies: [Movie]) {
        
        guard let coreDataData = Movie.loadCoreData() else {
            return
        }
        //let entity = coreDataData.0
        let entity = coreDataData.0
        let managedContext = coreDataData.1
        let moviesToDelete = fetch()
        self.deleteAllFromCoreData(moviesToDelete, managedContext)
        
        for movie in movies {
            let movieCoreData = NSManagedObject(entity: entity, insertInto: managedContext)
            movieCoreData.setValue(movie.name!, forKey: "title")
            movieCoreData.setValue(movie.date!, forKey: "date")
            movieCoreData.setValue(movie.overview!, forKey: "overview")
            movieCoreData.setValue(movie.genre.read(), forKey: "genre")
            movieCoreData.setValue(movie.id!, forKey: "id")
            let url = URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: movie.imagePath!))")
            ImageDownloader.default.downloadImage(with: url!, options: [], progressBlock: nil) {
                (image, error, url, data) in
                if error == nil {
                    movieCoreData.setValue(image?.jpegData(compressionQuality: 1.0), forKey: "image")
                } else {
                    movieCoreData.setValue(UIImage().jpegData(compressionQuality: 1.0), forKey: "image")
                }
                self.save(context: managedContext)
                managedContext.refreshAllObjects()
            }
        }
    }
    
    class func appendMoviesToCoreData(movies: [Movie]) {
        
        guard let coreDataData = Movie.loadCoreData() else {
            return
        }
        //let entity = coreDataData.0
        let entity = coreDataData.0
        let managedContext = coreDataData.1
        
        for movie in movies {
            let movieCoreData = NSManagedObject(entity: entity, insertInto: managedContext)
            movieCoreData.setValue(movie.name!, forKey: "title")
            movieCoreData.setValue(movie.date!, forKey: "date")
            movieCoreData.setValue(movie.overview!, forKey: "overview")
            movieCoreData.setValue(movie.genre.read(), forKey: "genre")
            movieCoreData.setValue(movie.id!, forKey: "id")
            let url = URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: movie.imagePath!))")
            ImageDownloader.default.downloadImage(with: url!, options: [], progressBlock: nil) {
                (image, error, url, data) in
                if error == nil {
                    movieCoreData.setValue(image?.jpegData(compressionQuality: 1.0), forKey: "image")
                } else {
                    movieCoreData.setValue(UIImage().jpegData(compressionQuality: 1.0), forKey: "image")
                }
                self.save(context: managedContext)
                managedContext.refreshAllObjects()
            }
        }
    }
    
    class func deleteAllFromCoreData(_ objetcs: [NSManagedObject], _ context: NSManagedObjectContext){
        for object in objetcs{
            context.delete(object)
        }
        save(context: context)
    }
    
    class func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Saving Sccessfull.")
        } catch let error as NSError {
            print("Could not save. \(error) \(error.userInfo)")
        }
    }
    
    class func getPopularMovies(pageToRequest: Int, onSuccess: @escaping (_ movies: [Movie]) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content_type": "aplication/json"]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/movie/popular?api_key=\(Tmdb.apiKey)&language=en-US&page=\(pageToRequest)", method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error requesting account details")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            guard let results = value["results"] as? [[String: Any]] else {
                onFailure("No movie results")
                return
            }
            var resultMovies: [Movie] = []
            for element in results {
                let movie = Movie(movie: element)
                //print(movie.genre)
                resultMovies.append(movie)
            }
            onSuccess(resultMovies)
        }
    }

    class func getFavoriteMovies(pageToRequest: Int, onSuccess: @escaping (_ movies: [Movie]) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content_type": "aplication/json"]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/account/\(String(describing: User.user.userId!))/favorite/movies?api_key=\(Tmdb.apiKey)&session_id=\(String(describing: User.user.sessionId!))&sort_by=created_at.asc&language=en-US&page=\(pageToRequest)", method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                print(response.result)
                onFailure("Request error requesting account details")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            guard let results = value["results"] as? [[String: Any]] else {
                onFailure("No movie results")
                return
            }
            var resultMovies: [Movie] = []
            for element in results {
                let movie = Movie(movie: element)
                //print(movie.genre)
                resultMovies.append(movie)
            }
            onSuccess(resultMovies)
        }
    }
    
    func setFavorite(movie: Movie, setAsFavorite: Bool, onSuccess: @escaping (_ success: Any) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content-type": "application/json"]
        var parameters: Parameters = [:]
        if setAsFavorite {
            parameters = [
                "media_type": "movie",
                "media_id": movie.id!,
                "favorite": 1
            ]
        } else {
            parameters = [
                "media_type": "movie",
                "media_id": movie.id!,
                "favorite": 0
            ]
        }
        
        print(parameters)
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/account/\(String(describing: User.user.userId!))/favorite?api_key=\(Tmdb.apiKey)&session_id=\(String(describing: User.user.sessionId!))", method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                //onFailure("Request error validating token")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                //onFailure("Data received is compromised")
                return
            }
            if let success = value["success"] as? Int {
                if success == 1 {
                    onSuccess(success)
                } else {
                    onFailure("Failed to set favorite")
                }
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
}
