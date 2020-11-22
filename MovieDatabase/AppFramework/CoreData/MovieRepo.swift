import CoreData
import os.log

public struct MovieRepo {
  public let get: (Int64) -> Movie?
  public let getAll: () -> [Movie]
  public let create: (Movie) -> Movie?
  public let delete: (Movie) -> Bool

  public init(
    get: @escaping (Int64) -> Movie?,
    getAll: @escaping () -> [Movie],
    create: @escaping (Movie) -> Movie?,
    delete: @escaping (Movie) -> Bool
  ) {
    self.get = get
    self.getAll = getAll
    self.create = create
    self.delete = delete
  }

  public static func `default`(moc: NSManagedObjectContext) -> MovieRepo {
    MovieRepo(
      get: { id in
        let fetchRequest = MOMovie.fetchRequest() as! NSFetchRequest<MOMovie>
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)
        do {
          let results = try moc.fetch(fetchRequest)
          if results.first != nil {
            os_log("Fetched MOMovie with id %i", log: generalLog, type: .debug, id)
          } else {
            os_log("Tryed to fetch MOMovie with id %i, but it doesn't exist", log: generalLog, type: .debug, id)
          }
          return results.first.map(Movie.init(moMovie:))
        } catch {
          os_log("Failed to get MOMovie with id %i, reason: %s", log: generalLog, type: .error, id, error.localizedDescription)
          return nil
        }
      },
      getAll: {
        let fetchRequest = MOMovie.fetchRequest() as! NSFetchRequest<MOMovie>
        do {
          let results = try moc.fetch(fetchRequest)
          os_log("Got all all MOMovie, count: %i", log: generalLog, type: .debug, results.count)
          return results.map(Movie.init(moMovie:))
        } catch {
          os_log("Failed to get all MOMovie, reason: %s", log: generalLog, type: .error)
          return []
        }
      },
      create: { movie in
        let moMovie = MOMovie(context: moc)
        moMovie.id = movie.id
        moMovie.title = movie.title
        moMovie.year = movie.year
        moMovie.overview = movie.overview
        moMovie.posterUrl = movie.posterUrl

        let moGenresFetchRequest = MOGenre.fetchRequest() as! NSFetchRequest<MOGenre>

        do {
          let genres = try moc.fetch(moGenresFetchRequest)
          let movieGenres = genres.filter { movie.genreIds.contains($0.id) }
          moMovie.genres = Set(movieGenres)
          try moc.save()
          os_log("Created MOMovie with id %i", log: generalLog, type: .debug, movie.id)
          return Movie(moMovie: moMovie)
        } catch {
          os_log("Failed to create MOMovie, reason: %s", log: generalLog, type: .error, error.localizedDescription)
          return nil
        }
      },
      delete: { movie in
        let fetchRequest = MOMovie.fetchRequest() as! NSFetchRequest<MOMovie>
        fetchRequest.predicate = NSPredicate(format: "id = %i", movie.id)
        do {
          if let moMovie = try moc.fetch(fetchRequest).first {
            moc.delete(moMovie)
            try moc.save()
            os_log("Deleted MOMovie with id %i", log: generalLog, type: .debug, movie.id)
            return true
          } else {
            os_log("Failed to delete MOMovie with id %i, reason: failed to fetch movie", log: generalLog, type: .error, movie.id)
            return false
          }
        } catch {
          os_log("Failed to delete MOMovie with id %i, reason: %s", log: generalLog, type: .error, movie.id, error.localizedDescription)
          return false
        }
      }
    )
  }
}
