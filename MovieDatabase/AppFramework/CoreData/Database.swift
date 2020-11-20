import CoreData

public class Database {
  private enum Constants {
    static let databaseName: String = "Movies"
  }

  public let container: NSPersistentContainer
  public var moc: NSManagedObjectContext {
    container.viewContext
  }

  public convenience init() {
    let thisBundle = Bundle(for: Database.self)
    guard let managedObjectModel = NSManagedObjectModel.mergedModel(from: [thisBundle]) else {
      fatalError("Can't find DB")
    }
    self.init(name: Constants.databaseName, managedObjectModel: managedObjectModel)
  }

  public init(name: String, managedObjectModel: NSManagedObjectModel) {
    container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)
  }

  public func loadStore() {
    container.loadPersistentStores(completionHandler: { _, _ in })
  }
}
