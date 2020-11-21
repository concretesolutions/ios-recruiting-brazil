import Foundation

public struct GenresResponse: Codable, Equatable {
  public struct Genre: Codable, Equatable {
    public let id: Int16
    public let name: String

    public init(
      id: Int16,
      name: String
    ) {
      self.id = id
      self.name = name
    }
  }

  public let genres: [Genre]

  public init(
    genres: [Genre]
  ) {
    self.genres = genres
  }
}

extension Request {
  static func genres() -> Request {
    Request(
      path: "/genre/movie/list",
      httpMethod: .get,
      queryItems: nil
    )
  }
}
