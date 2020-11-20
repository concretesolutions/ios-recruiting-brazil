import CoreData

public final class MOMovie: NSManagedObject {
  @NSManaged public var id: Int64
  @NSManaged public var title: String
  @NSManaged public var overview: String
}
