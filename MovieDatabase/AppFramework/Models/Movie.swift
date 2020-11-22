public struct Movie: Equatable, Hashable {
  public let id: Int64
  public let title: String
  public let year: String
  public let genreIds: [Int16]
  public let overview: String
  public let posterUrl: URL

  public init(
    id: Int64,
    title: String,
    year: String,
    genreIds: [Int16],
    overview: String,
    posterUrl: URL
  ) {
    self.id = id
    self.title = title
    self.year = year
    self.genreIds = genreIds
    self.overview = overview
    self.posterUrl = posterUrl
  }

  public init(moMovie: MOMovie) {
    id = moMovie.id
    title = moMovie.title
    year = moMovie.year
    genreIds = moMovie.genres.map(\.id)
    overview = moMovie.overview
    posterUrl = moMovie.posterUrl
  }
}
