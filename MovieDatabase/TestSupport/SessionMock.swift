import AppFramework
import Combine
import TheMovieDatabaseApi

public struct SessionMock: Session {
  public let result: Result<(data: Data, response: URLResponse), URLError>

  public init(result: Result<(data: Data, response: URLResponse), URLError>) {
    self.result = result
  }

  public func customDataTaskPublisher(for _: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    Deferred {
      Future<(data: Data, response: URLResponse), URLError> { promise in
        promise(result)
      }
    }
    .eraseToAnyPublisher()
  }
}

public extension TMDClient {
  static func mock(with error: URLError) -> TMDClient {
    TMDClient(
      session: SessionMock(result: .failure(error)),
      baseUrl: TestConstants.exampleUrl,
      middlewares: []
    )
  }

  static func mock(with data: Data, andResponse response: URLResponse) -> TMDClient {
    TMDClient(
      session: SessionMock(result: .success((data: data, response: response))),
      baseUrl: TestConstants.exampleUrl,
      middlewares: []
    )
  }
}
