import CoreData
import os.log

public struct MOGenreRepo {
  public let getAll: () -> [MOGenre]

  public init(
    getAll: @escaping () -> [MOGenre]
  ) {
    self.getAll = getAll
  }

  public static func `default`(moc: NSManagedObjectContext) -> MOGenreRepo {
    MOGenreRepo(
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
