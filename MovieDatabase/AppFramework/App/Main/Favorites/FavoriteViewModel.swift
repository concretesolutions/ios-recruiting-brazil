public struct FavoriteViewModel: Identifiable, Hashable {
  public let id: Int64
  public let title: String
  public let year: String
  public let overview: String
  public let genres: [String]

  public init(
    id: Int64,
    title: String,
    year: String,
    overview: String,
    genres: [String]
  ) {
    self.id = id
    self.title = title
    self.year = year
    self.overview = overview
    self.genres = genres
  }
}
