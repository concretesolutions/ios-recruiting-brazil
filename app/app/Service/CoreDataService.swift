//
//  CoreDataService.swift
//  app
//
//  Created by rfl3 on 20/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import CoreData

class CoreDataService {

    public static var shared = CoreDataService()
    var user: User?

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var persistentContainer: NSPersistentContainer

    init() {
        let container: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
            let container = NSPersistentContainer(name: "app")

            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                } else {
                    print(storeDescription)
                }
            })

            return container
        }()

        self.persistentContainer = container

        self.user = self.fetchUser()
    }

    // MARK: - Core Data Saving support
    func saveContext() throws {
        if context.hasChanges {
            do {
                try self.context.save()

            } catch let error as NSError {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                print(error)
                throw error
            }
        }
    }

    func fetchUser() -> User {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")

        do {
            let user = try context.fetch(fetchRequest)
            if let first = user.first {
                return first
            } else {
                let user = User(context: self.context)
                try? self.saveContext()
                return user
            }
        } catch {
            print(error)
            let user = User(context: self.context)
            try? self.saveContext()
            return user
        }
    }

    func favoriteMovie(_ movie: Movie) {
        self.user?.addToMovies(self.translateMovie(movie))
        
        try? self.saveContext()
    }

    func translateMovie(_ movie: Movie) -> MovieCD {
        let movieCD = MovieCD(context: self.context)

        movieCD.backdropPath = movie.backdropPath
        movieCD.genreIds = movie.genreIds
        movieCD.overview = movie.overview
        movieCD.posterPath = movie.posterPath
        movieCD.releaseDate = movie.releaseDate
        movieCD.title = movie.title

        if let id = movie.id {
            movieCD.id = Int64(id)
        }

        return movieCD

    }

    func translateMovieCD(_ movieCD: MovieCD) -> Movie {
        var movie = Movie()

        movie.backdropPath = movieCD.backdropPath
        movie.genreIds = movieCD.genreIds
        movie.overview = movieCD.overview
        movie.posterPath = movieCD.posterPath
        movie.releaseDate = movieCD.releaseDate
        movie.title = movieCD.title
        movie.id = Int(movieCD.id)

        return movie
    }

    func unfavoriteMovie(_ movie: Movie) {
        guard let id = movie.id else { return }
        let movieCD = self.user?.movies?.filter{
            ($0 as! MovieCD).id == id
        }.first as! MovieCD
        self.user?.removeFromMovies(movieCD)

        try? self.saveContext()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        guard let id = movie.id else { return false }
        return self.user?.movies?.contains{
            ($0 as! MovieCD).id == Int64(id)
            } ?? false
    }

    func fetchFavorites() -> [Movie]? {
        guard let user = self.user,
            let moviesCD = user.movies
            else { return nil }

        return moviesCD.map { self.translateMovieCD($0 as! MovieCD) }

    }

}
