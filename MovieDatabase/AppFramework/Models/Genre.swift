public struct Genre: Equatable, Hashable {
  public let id: Int16
  public let name: String

  public init(
    id: Int16,
    name: String
  ) {
    self.id = id
    self.name = name
  }

  public init(
    moGenre: MOGenre
  ) {
    id = moGenre.id
    name = moGenre.name
  }
}
