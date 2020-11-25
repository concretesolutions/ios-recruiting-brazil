import Foundation

public struct ErrorResponse: Decodable, Error, Equatable {
  public let statusMessage: String
  public let statusCode: Int

  public init(
    statusMessage: String,
    statusCode: Int
  ) {
    self.statusMessage = statusMessage
    self.statusCode = statusCode
  }
}
