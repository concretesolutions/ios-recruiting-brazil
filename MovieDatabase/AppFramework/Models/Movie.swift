public struct Movie {
  public let id: Int64
  public let title: String
  public let year: String
  public let genreIds: [Int16]
  public let overview: String

  public init(
    id: Int64,
    title: String,
    year: String,
    genreIds: [Int16],
    overview: String
  ) {
    self.id = id
    self.title = title
    self.year = year
    self.genreIds = genreIds
    self.overview = overview
  }
}
