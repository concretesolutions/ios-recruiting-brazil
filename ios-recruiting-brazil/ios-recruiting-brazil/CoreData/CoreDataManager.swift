//
//  CoreDataManager.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager: NSObject {

    func saveMovie(name: String, genres: String, overview: String, date: String, image: UIImage?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let movie = Movie(context: context)
        movie.name = name
        movie.genres = genres
        movie.overview = overview
        movie.date = date
        movie.image = image?.pngData()
        do {
            try context.save()
        } catch {
            fatalError("Failure to get context\(error)")
        }
    }

    func fetchMovies() -> [Movie]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        let context = appDelegate.persistentContainer.viewContext
        let moviesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        if let fetchedMovies = try? context.fetch(moviesFetch) as? [Movie] {
            return fetchedMovies
        }
        return nil
    }

    func deleteMovie(withName name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        guard let movies = fetchMovies() else {
            return
        }

        movies.forEach({
            if $0.name == name {
                context.delete($0)
            }
        })

        do {
            try context.save()
        } catch {
            fatalError("Failure to get context\(error)")
        }
    }

    func searchForMovie(withName name: String) -> Movie? {
        var movie: Movie?
        guard let movies = fetchMovies() else {
            return nil
        }
        movies.forEach({
            if $0.name == name {
                movie = $0
            }
        })
        return movie
    }

    func resetCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        guard let movies = fetchMovies() else {
            return
        }

        movies.forEach({
            context.delete($0)
        })

        do {
            try context.save()
        } catch {
            fatalError("Failure to get context\(error)")
        }
    }
}
