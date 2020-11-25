import AppFramework
import Combine
import TheMovieDatabaseApi

public class SessionMock: Session {
  private var results: [Result<(data: Data, response: URLResponse), URLError>]

  public init(results: [Result<(data: Data, response: URLResponse), URLError>]) {
    self.results = results
  }

  public func customDataTaskPublisher(for _: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    let result = results.removeFirst()
    return Deferred {
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
      session: SessionMock(results: [.failure(error)]),
      baseUrl: TestConstants.exampleUrl,
      middlewares: []
    )
  }

  static func mock(with data: Data, andResponse response: URLResponse) -> TMDClient {
    TMDClient(
      session: SessionMock(results: [.success((data: data, response: response))]),
      baseUrl: TestConstants.exampleUrl,
      middlewares: []
    )
  }

  static func mock(with results: [(data: Data, response: URLResponse)]) -> TMDClient {
    let _results = results.map(Result<(data: Data, response: URLResponse), URLError>.success)
    return TMDClient(
      session: SessionMock(results: _results),
      baseUrl: TestConstants.exampleUrl,
      middlewares: []
    )
  }
}
