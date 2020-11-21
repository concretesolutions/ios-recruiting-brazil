import CoreData

public final class MOGenre: NSManagedObject {
  @NSManaged public var id: Int16
  @NSManaged public var name: String
  @NSManaged public var movies: Set<MOMovie>

  override public func awakeFromInsert() {
    super.awakeFromInsert()
    movies = .init()
  }
}
