//
//  GenreDataManager.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 11/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation
import CoreData

class GenreDataManager {
    
    private let movieData: String = "MovieData"
    private let genresEntity: String = "Genres"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: movieData)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var genres: [Genres] = []
    
    func saveGenres(genresToSave: [Genre]) {
        
        var arrayCoreData:[Genres] = []
        loadGenres { (array) in
            arrayCoreData = array
        }
        
        let context = persistentContainer.viewContext
        for genre in genresToSave {
            let genreSelected = arrayCoreData.filter{$0.id == Int32(genre.id)}
            let genres = Genres(context: context)
            if genreSelected.count < 0 {
                genres.id = Int32(genre.id)
                genres.name = genre.name
                do {
                    try context.save()
                } catch {
                    print("Error - DataManager - saveGenres()")
                }
            }
        }
    }
    
    func loadGenres(completion: ([Genres]) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: genresEntity)
        let result = try? context.fetch(request)
        genres = result as? [Genres] ?? []
        completion(genres)
    }
    
    func getGenreString(movie: Movie?) -> String {
        var stringFormatter: String = ""
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
