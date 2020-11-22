public struct Movie {
  public let id: Int64
  public let title: String
  public let year: String
  public let genre: [Genre]
  public let overview: String

  public init(
    id: Int64,
    title: String,
    year: String,
    genre: [Genre],
    overview: String
  ) {
    self.id = id
    self.title = title
    self.year = year
    self.genre = genre
    self.overview = overview
  }
}
