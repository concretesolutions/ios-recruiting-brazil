import Foundation

public struct MovieDetailsViewModel {
  public let id: Int64
  public let poster: String
  public let title: String
  public let year: String
  public let genres: [String]
  public let overview: String

  public init(
    id: Int64,
    poster: String,
    title: String,
    year: String,
    genres: [String],
    overview: String
  ) {
    self.id = id
    self.poster = poster
    self.title = title
    self.year = year
    self.genres = genres
    self.overview = overview
  }
}
