import Foundation

public struct MovieDetailsViewModel {
  public let movie: Movie
  public let metadata: MetaData
  public var genres: [String] {
    metadata.genres?
      .filter { genre in movie.genreIds.contains(genre.id) }
      .map(\.name) ?? ["Failed to get genres"]
  }

  public init(
    movie: Movie,
    metadata: MetaData
  ) {
    self.movie = movie
    self.metadata = metadata
  }
}
