//
//  DataManager.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation
import CoreData


class DataManager {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieSave")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var arrayMovieSave:[MovieSave] = []
    var arrayGenresSave:[Genres] = []
    
    func saveMovieCoreData(movie: MovieSave) {
        let context = persistentContainer.viewContext
        let movieSave = MovieSave(context: context)
        
        movieSave.title = movie.title
        movieSave.releaseDate = movie.releaseDate
        movieSave.overview = movie.overview
        movieSave.imageURL = movie.imageURL
        movieSave.genres = movie.genres
        movieSave.id = movie.id
        
        do {
            try context.save()
        }catch {
            print("Error - DataManager - saveMovie() ")
        }
        
    }

    func saveMovie(movieToSave: Movie, genres: String) {

        let context = persistentContainer.viewContext
        let movie = MovieSave(context: context)
        
        movie.title = movieToSave.title
        movie.releaseDate = movieToSave.releaseDate
        movie.overview = movieToSave.overview
        movie.imageURL = movieToSave.backdropPath
        movie.genres = genres
        movie.id = Int64(movieToSave.id)
        
        do {
            try context.save()
        }catch {
            print("Error - DataManager - saveMovie() ")
        }
    }
    
    func saveGenres(genresToSave: [Genre]) {
        var arrayCoreData:[Genres] = []
        loadGenres { (array) in
            arrayCoreData = array
        }
        
        let context = persistentContainer.viewContext
        for genre in genresToSave {
            let genreSelected = arrayCoreData.filter{$0.id == Int32(genre.id)}
            let genres = Genres(context: context)
            if genreSelected.count > 0  {
                print("Ja Existe")
            }else {
                genres.id = Int32(genre.id)
                genres.name = genre.name
                do {
                    try context.save()
                }catch {
                    print("Error - DataManager - saveGenres()")
                }
            }
        }
        
    }
    
    func loadGenres(completion: ([Genres]) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Genres")
        let result = try? context.fetch(request)
        arrayGenresSave = result as? [Genres] ?? []
        completion(arrayGenresSave)
    }

    func loadMovie(completion: ([MovieSave])-> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieSave")
        let result = try? context.fetch(request)
        arrayMovieSave = result as? [MovieSave] ?? []
        completion(arrayMovieSave)
    }

    func delete(id: NSManagedObjectID, completion: (Bool) -> Void) -> Void {
        let context = persistentContainer.viewContext
        let obj = context.object(with: id)

        context.delete(obj)
        do {
            try context.save()
            completion(true)
        }catch {
            completion(false)
        }
    }
    
    func getGenreString(movie: Movie?) -> String {
        var stringFormatter:String = ""
        self.loadGenres { (arrayGenre) in
            if let movieSelected = movie {
                for genreMovie in movieSelected.genreIDS {
                    for genreCoreData in arrayGenre {
                        if genreCoreData.id == Int32(genreMovie) {
                            stringFormatter += (genreCoreData.name ?? "") + " | "
                        }
                    }
                }
            }
        }
        return stringFormatter
    }
}
