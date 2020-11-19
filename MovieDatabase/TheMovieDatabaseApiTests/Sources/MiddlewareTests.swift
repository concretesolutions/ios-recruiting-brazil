@testable import TheMovieDatabaseApi
import XCTest

final class MiddlewareTests: XCTestCase {
  private let baseUrl = URL(string: "https://example.com")!

  func testApply_WithDefaulHeadersMiddleware() {
    var urlRequest = URLRequest(url: baseUrl)
    Middleware.defaultHeadersMiddleware().apply(&urlRequest)
    XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type": "application/json;charset=utf-8"])
  }

  func testApply_WithAuthenticationMiddleware() {
    var urlRequest = URLRequest(url: baseUrl)
    Middleware.authenticationMiddleware(apiKey: "123").apply(&urlRequest)
    XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Authorization": "Bearer 123"])
  }

  func testApply_WithMultipleMiddlewares() {
    var urlRequest = URLRequest(url: baseUrl)
    let middlewares = [
      Middleware.defaultHeadersMiddleware(),
      Middleware.authenticationMiddleware(apiKey: "123"),
    ]
    middlewares.apply(to: &urlRequest)
    XCTAssertEqual(urlRequest.allHTTPHeaderFields, [
      "Content-Type": "application/json;charset=utf-8",
      "Authorization": "Bearer 123",
    ])
  }
}
