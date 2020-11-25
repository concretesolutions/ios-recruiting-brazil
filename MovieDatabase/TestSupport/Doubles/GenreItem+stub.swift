import AppFramework

public extension GenreItem {
  static func stubSelected(
    id: Int16 = 0,
    name: String = ""
  ) -> GenreItem {
    .init(genre: Genre(id: id, name: name), selected: true)
  }

  static func stubNotSelected(
    id: Int16 = 0,
    name: String = ""
  ) -> GenreItem {
    .init(genre: Genre(id: id, name: name), selected: false)
  }
}
