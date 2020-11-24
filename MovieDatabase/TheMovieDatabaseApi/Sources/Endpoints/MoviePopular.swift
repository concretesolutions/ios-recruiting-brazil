import Foundation

public struct MoviePopularRequestParams {
  public let page: Int

  public init(page: Int) {
    self.page = page
  }
}

public struct MoviePopularResponse: Codable, Equatable {
  public struct Movie: Codable, Equatable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String
    public let releaseDate: String
    public let genreIds: [Int16]

    public init(
      id: Int,
      title: String,
      overview: String,
      posterPath: String,
      releaseDate: String,
      genreIds: [Int16]
    ) {
      self.id = id
      self.title = title
      self.overview = overview
      self.posterPath = posterPath
      self.releaseDate = releaseDate
      self.genreIds = genreIds
    }
  }

  public let page: Int
  public let totalResults: Int
  public let totalPages: Int
  public let results: [Movie]

  public init(
    page: Int,
    totalResults: Int,
    totalPages: Int,
    results: [Movie]
  ) {
    self.page = page
    self.totalResults = totalResults
    self.totalPages = totalPages
    self.results = results
  }
}

extension Request {
  static func moviePopular(params: MoviePopularRequestParams) -> Request {
    Request(
      path: "/movie/popular",
      httpMethod: .get,
      queryItems: [
        URLQueryItem(name: "page", value: String(params.page)),
      ]
    )
  }
}
