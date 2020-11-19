import Foundation

public struct DiscoverMovieRequestParams {
  public let page: Int

  public init(page: Int) {
    self.page = page
  }
}

public struct DiscoverMovieResponse: Decodable, Equatable {
  public struct Movie: Decodable, Equatable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String
    public let releaseDate: String
  }

  public let page: Int
  public let totalResults: Int
  public let totalPages: Int
  public let results: [Movie]
}

extension Request {
  static func discoverMovie(params: DiscoverMovieRequestParams) -> Request {
    Request(
      path: "/discover/movie",
      httpMethod: .get,
      queryItems: [
        URLQueryItem(name: "page", value: String(params.page)),
      ]
    )
  }
}
