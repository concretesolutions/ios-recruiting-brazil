import Combine

public final class TMDClient {
  public typealias ResponsePublisher<T> = AnyPublisher<Result<T, ErrorResponse>, Never>

  private let provider: Provider

  public init(baseUrl: URL, middlewares: [Middleware]) {
    let session = URLSession(configuration: .default)
    provider = Provider(session: session, baseUrl: baseUrl, middlewares: middlewares)
  }

  public func discoverMovie(_ params: DiscoverMovieRequestParams) -> ResponsePublisher<DiscoverMovieResponse> {
    provider.executeWithResult(request: .discoverMovie(params: params))
  }
}
