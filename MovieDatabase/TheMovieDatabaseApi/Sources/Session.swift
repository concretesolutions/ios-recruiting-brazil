import Combine

public protocol Session {
  func customDataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: Session {
  public func customDataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    dataTaskPublisher(for: request).eraseToAnyPublisher()
  }
}
