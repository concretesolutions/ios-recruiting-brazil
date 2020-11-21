import Foundation

public struct ConfigurationResponse: Codable, Equatable {
  public struct Images: Codable, Equatable {
    public let secureBaseUrl: URL
    public let posterSizes: [String]

    public init(
      secureBaseUrl: URL,
      posterSizes: [String]
    ) {
      self.secureBaseUrl = secureBaseUrl
      self.posterSizes = posterSizes
    }
  }

  public let images: Images

  public init(
    images: Images
  ) {
    self.images = images
  }
}

extension Request {
  static func configuration() -> Request {
    Request(
      path: "/configuration",
      httpMethod: .get,
      queryItems: nil
    )
  }
}
