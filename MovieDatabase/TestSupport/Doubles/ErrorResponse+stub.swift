import TheMovieDatabaseApi

public extension ErrorResponse {
  static func stub(statusMessage: String = "", statusCode: Int = 0) -> ErrorResponse {
    ErrorResponse(
      statusMessage: statusMessage, statusCode: statusCode
    )
  }

  static func stub(urlError: URLError) -> ErrorResponse {
    ErrorResponse(
      statusMessage: urlError.localizedDescription, statusCode: -999
    )
  }
}
