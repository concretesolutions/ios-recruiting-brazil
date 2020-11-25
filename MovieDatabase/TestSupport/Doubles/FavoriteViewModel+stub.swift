import AppFramework

public extension FavoriteViewModel {
  static func stub(movie: Movie) -> FavoriteViewModel {
    FavoriteViewModel(movie: movie)
  }

  static func stubMovie(
    id: Int64 = 0,
    title: String = "",
    year: String = "",
    genreIds: [Int16] = []
  ) -> FavoriteViewModel {
    FavoriteViewModel(movie: .stub(id: id, title: title, year: year, genreIds: genreIds))
  }
}
