import TheMovieDatabaseApi

public extension MoviePopularResponse {
  static func stub(
    page: Int = 0,
    pageResults: Int = 0,
    totalPages: Int = 0,
    results: [Movie] = []
  ) -> MoviePopularResponse {
    MoviePopularResponse(
      page: page,
      totalResults: pageResults,
      totalPages: totalPages,
      results: results
    )
  }

  func toData() throws -> Data {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return try encoder.encode(self)
  }
}

public extension MoviePopularResponse.Movie {
  static func stub(
    id: Int = 0,
    title: String = "",
    overview: String = "",
    posterPath: String = "",
    releaseDate: String = "",
    genreIds: [Int16] = []
  ) -> MoviePopularResponse.Movie {
    MoviePopularResponse.Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      genreIds: genreIds
    )
  }
}
