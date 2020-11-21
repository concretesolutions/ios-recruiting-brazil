import Foundation

public struct ConfigurationResponse: Codable, Equatable {
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

extension Request {
  static func configuration() -> Request {
    Request(
      path: "/configuration",
      httpMethod: .get,
      queryItems: nil
    )
  }
}
