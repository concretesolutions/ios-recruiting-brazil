import AppFramework

public extension Genre {
  static func stub(
    id: Int16 = 0, name: String = ""
  ) -> Genre {
    Genre(id: id, name: name)
  }
}
