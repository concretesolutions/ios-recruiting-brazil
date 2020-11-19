import Combine
@testable import TheMovieDatabaseApi
import XCTest

struct SessionMock: Session {
  let result: Result<(data: Data, response: URLResponse), URLError>

  func customDataTaskPublisher(for _: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    Future<(data: Data, response: URLResponse), URLError> { promise in promise(self.result) }.eraseToAnyPublisher()
  }
}

final class ProviderTests: XCTestCase {
  private let baseUrl = URL(string: "https://example.com")!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    cancellables = .init()
  }

  override func tearDownWithError() throws {
    cancellables = nil
  }

  private func makeProvider(session: Session) -> Provider {
    Provider(
      session: session,
      baseUrl: baseUrl,
      middlewares: []
    )
  }

  private func assertExecute(
    sessionMock: SessionMock,
    assertions: @escaping (Result<[Int], ErrorResponse>) -> Void
  ) {
    let provider = makeProvider(session: sessionMock)
    let publisher: AnyPublisher<Result<[Int], ErrorResponse>, Never> = provider.executeWithResult(request: .init(path: "/path/to/somewhere", httpMethod: .get, queryItems: nil))

    let valueExpectation = expectation(description: "value")

    publisher.sink(
      receiveValue: { result in
        assertions(result)
        valueExpectation.fulfill()
      }
    )
    .store(in: &cancellables)

    waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testExecute_WithSuccessfulResponse_ShouldDecodeValue() {
    let responseData = "[1, 2, 3]".data(using: .utf8)!
    let urlResponse = HTTPURLResponse(url: baseUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let session = SessionMock(result: .success((data: responseData, response: urlResponse)))
    assertExecute(
      sessionMock: session,
      assertions: { result in
        switch result {
        case .failure: XCTFail()
        case let .success(values):
          XCTAssertEqual([1, 2, 3], values)
        }
      }
    )
  }

  func testExecute_WithCorrectErrorResponse_ShouldDecodeError() {
    let responseData = "{\"status_message\": \"foo\",\"status_code\": 1}".data(using: .utf8)!
    let urlResponse = HTTPURLResponse(url: baseUrl, statusCode: 401, httpVersion: nil, headerFields: nil)!
    let session = SessionMock(result: .success((data: responseData, response: urlResponse)))
    assertExecute(
      sessionMock: session,
      assertions: { result in
        switch result {
        case let .failure(errorResponse):
          XCTAssertEqual(errorResponse.statusMessage, "foo")
          XCTAssertEqual(errorResponse.statusCode, 1)
        case .success:
          XCTFail()
        }
      }
    )
  }

  func testExecute_WithUnknownErrorResponse_ShouldDecodeError() {
    let responseData = "{}".data(using: .utf8)!
    let urlResponse = HTTPURLResponse(url: baseUrl, statusCode: 401, httpVersion: nil, headerFields: nil)!
    let session = SessionMock(result: .success((data: responseData, response: urlResponse)))
    assertExecute(
      sessionMock: session,
      assertions: { result in
        switch result {
        case let .failure(errorResponse):
          XCTAssertEqual(errorResponse.statusMessage, "The data couldn’t be read because it is missing.")
          XCTAssertEqual(errorResponse.statusCode, -999)
        case .success:
          XCTFail()
        }
      }
    )
  }
}
