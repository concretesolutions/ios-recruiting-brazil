import Combine
import os.log

class Provider {
  let session: Session
  let baseUrl: URL
  let middlewares: [Middleware]

  init(session: Session, baseUrl: URL, middlewares: [Middleware]) {
    self.session = session
    self.baseUrl = baseUrl
    self.middlewares = middlewares
  }

  func executeWithResult<T: Decodable>(request: Request) -> AnyPublisher<Result<T, ErrorResponse>, Never> {
    execute(request: request)
      .flatMap { t in
        Just<Result<T, ErrorResponse>>(.success(t))
      }
      .catch { errorResponse in
        Just<Result<T, ErrorResponse>>(.failure(errorResponse))
      }
      .eraseToAnyPublisher()
  }

  func execute<T: Decodable>(request: Request) -> AnyPublisher<T, ErrorResponse> {
    execute(request: request)
      .tryMap { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse else {
          throw URLError(.badServerResponse)
        }

        guard httpResponse.statusCode == 200 else {
          throw try JSONDecoder.default.decode(ErrorResponse.self, from: element.data)
        }

        return element.data
      }
      .decode(type: T.self, decoder: JSONDecoder.default)
      .mapError { error -> ErrorResponse in
        if let errorResponse = error as? ErrorResponse {
          return errorResponse
        } else {
          return ErrorResponse(statusMessage: error.localizedDescription, statusCode: -999)
        }
      }
      .eraseToAnyPublisher()
  }

  private func execute(request: Request) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    var urlRequest = request.makeUrlRequest(baseUrl: baseUrl)
    middlewares.apply(to: &urlRequest)

    os_log("Executing request %s %s", log: generalLog, type: .debug, request.httpMethod.rawValue, request.path)
    return session
      .customDataTaskPublisher(for: urlRequest)
  }
}
