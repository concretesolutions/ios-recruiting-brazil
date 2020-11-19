import Foundation

public struct ErrorResponse: Decodable, Error {
  public let statusMessage: String
  public let statusCode: Int
}
