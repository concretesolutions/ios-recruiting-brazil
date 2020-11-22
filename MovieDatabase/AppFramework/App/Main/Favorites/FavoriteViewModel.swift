public struct FavoriteViewModel: Identifiable, Hashable {
  public let movie: Movie
  public var id: Int64 { movie.id }

  public init(
    movie: Movie
  ) {
    self.movie = movie
  }
}
