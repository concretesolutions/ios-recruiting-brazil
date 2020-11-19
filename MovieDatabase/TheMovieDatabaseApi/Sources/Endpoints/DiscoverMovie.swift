import Foundation

public struct DiscoverMovieRequestParams {
  public let page: Int
}

public struct DiscoverMovieResponse: Decodable {
  public struct Movie: Decodable {
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
