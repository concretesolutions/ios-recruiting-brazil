@testable import TheMovieDatabaseApi
import XCTest

final class RequestTests: XCTestCase {
  private let baseUrl = URL(string: "https://example.com")!

  func testMakeUrlRequest_WithGetAndNoQueryItems() throws {
    let request = Request(
      path: "/path/to/somewhere",
      httpMethod: .get,
      queryItems: nil
    )

    let urlRequest = request.makeUrlRequest(baseUrl: baseUrl)

    XCTAssertEqual(urlRequest.httpMethod, "GET")
    XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/path/to/somewhere")
  }

  func testMakeUrlRequest_WithGetAndQueryItems() throws {
    let request = Request(
      path: "/path/to/somewhere",
      httpMethod: .get,
      queryItems: [
        .init(name: "foo", value: "bar"),
      ]
    )

    let urlRequest = request.makeUrlRequest(baseUrl: baseUrl)

    XCTAssertEqual(urlRequest.httpMethod, "GET")
    XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/path/to/somewhere?foo=bar")
  }
}
