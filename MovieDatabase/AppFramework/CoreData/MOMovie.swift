import CoreData
public final class MOMovie: NSManagedObject {
  @NSManaged public var id: Int64
  @NSManaged public var title: String
  @NSManaged public var overview: String
}

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
      // TODO: Use os log
      print(error.localizedDescription)
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
      // TODO: Use os log
      print(error.localizedDescription)
      return nil
    }
  }

  @discardableResult public func delete(_ movie: MOMovie) -> Bool {
    do {
      moc.delete(movie)
      try moc.save()
      return true
    } catch {
      // TODO: Use os log
      print(error.localizedDescription)
      return false
    }
  }
}
