import CoreData
import os.log

public class MOMovieRepo {
  private let moc: NSManagedObjectContext

  public init(moc: NSManagedObjectContext) {
    self.moc = moc
  }

  public func get(_ id: Int) -> MOMovie? {
    let fetchRequest = MOMovie.fetchRequest() as! NSFetchRequest<MOMovie>
    fetchRequest.predicate = NSPredicate(format: "id = %i", id)
    do {
      let results = try moc.fetch(fetchRequest)
      return results.first
    } catch {
      os_log("Failed to get MOMovie with id %i, reason: %s", log: generalLog, type: .error, id, error.localizedDescription)
      return nil
    }
  }

  @discardableResult public func create(_ f: @escaping (inout MOMovie) -> Void) -> MOMovie? {
    var movie = MOMovie(context: moc)
    f(&movie)
    do {
      try moc.save()
      return movie
    } catch {
      os_log("Failed to create MOMovie, reason: %s", log: generalLog, type: .error, error.localizedDescription)
      return nil
    }
  }

  @discardableResult public func delete(_ movie: MOMovie) -> Bool {
    do {
      moc.delete(movie)
      try moc.save()
      return true
    } catch {
      os_log("Failed to delete MOMovie with id %i, reason: %s", log: generalLog, type: .error, movie.id, error.localizedDescription)
      return false
    }
  }
}
