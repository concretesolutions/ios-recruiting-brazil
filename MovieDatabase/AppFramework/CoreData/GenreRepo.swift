import CoreData
import os.log

public struct GenreRepo {
  public let get: (Int16) -> MOGenre?
  public let getAll: () -> [MOGenre]

  public init(
    get: @escaping (Int16) -> MOGenre?,
    getAll: @escaping () -> [MOGenre]
  ) {
    self.get = get
    self.getAll = getAll
  }

  public static func `default`(moc: NSManagedObjectContext) -> GenreRepo {
    GenreRepo(
      get: { id in
        let fetchRequest = MOGenre.fetchRequest() as! NSFetchRequest<MOGenre>
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)
        do {
          let results = try moc.fetch(fetchRequest)
          if results.first != nil {
            os_log("Fetched MOGenre with id %i", log: generalLog, type: .debug, id)
          } else {
            os_log("Tryed to fetch MOGenre with id %i, but it doesn't exist", log: generalLog, type: .debug, id)
          }
          return results.first
        } catch {
          os_log("Failed to get MOGenre with id %i, reason: %s", log: generalLog, type: .error, id, error.localizedDescription)
          return nil
        }
      },
      getAll: {
        let fetchRequest = MOGenre.fetchRequest() as! NSFetchRequest<MOGenre>
        do {
          let results = try moc.fetch(fetchRequest)
          os_log("Got all all MOGenre, count: %i", log: generalLog, type: .debug, results.count)
          return results
        } catch {
          os_log("Failed to get all MOGenre, reason: %s", log: generalLog, type: .error)
          return []
        }
      }
    )
  }
}
