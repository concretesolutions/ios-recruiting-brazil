import AppFramework

public extension Movie {
  static func stub(
    id: Int64 = 0,
    title: String = "",
    year: String = "",
    genreIds: [Int16] = [],
    overview: String = "",
    posterUrl: URL = TestConstants.exampleUrl.appendingPathComponent("w300/")
  ) -> Movie {
    Movie(
      id: id,
      title: title,
      year: year,
      genreIds: genreIds,
      overview: overview,
      posterUrl: posterUrl
    )
  }
}
