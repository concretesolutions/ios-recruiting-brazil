import CoreData
import os.log

public struct MOMovieRepo {
  public let get: (Int) -> MOMovie?
  public let create: ((inout MOMovie) -> Void) -> MOMovie?
  public let delete: (MOMovie) -> Bool

  public init(
    get: @escaping (Int) -> MOMovie?,
    create: @escaping ((inout MOMovie) -> Void) -> MOMovie?,
    delete: @escaping (MOMovie) -> Bool
  ) {
    self.get = get
    self.create = create
    self.delete = delete
  }

  public static func `default`(moc: NSManagedObjectContext) -> MOMovieRepo {
    MOMovieRepo(
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
          return results.first
        } catch {
          os_log("Failed to get MOMovie with id %i, reason: %s", log: generalLog, type: .error, id, error.localizedDescription)
          return nil
        }
      },
      create: { applyChanges in
        var movie = MOMovie(context: moc)
        applyChanges(&movie)
        do {
          try moc.save()
          os_log("Created MOMovie with id %i", log: generalLog, type: .debug, movie.id)
          return movie
        } catch {
          os_log("Failed to create MOMovie, reason: %s", log: generalLog, type: .error, error.localizedDescription)
          return nil
        }
      },
      delete: { movie in
        do {
          moc.delete(movie)
          try moc.save()
          os_log("Deleted MOMovie with id %i", log: generalLog, type: .debug, movie.id)
          return true
        } catch {
          os_log("Failed to delete MOMovie with id %i, reason: %s", log: generalLog, type: .error, movie.id, error.localizedDescription)
          return false
        }
      }
    )
  }
}
