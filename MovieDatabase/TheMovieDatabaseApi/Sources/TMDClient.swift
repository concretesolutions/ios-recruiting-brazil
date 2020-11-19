import Combine

public final class TMDClient {
  private let provider: Provider

  public init(baseUrl: URL, middlewares: [Middleware]) {
    let session = URLSession(configuration: .default)
    provider = Provider(session: session, baseUrl: baseUrl, middlewares: middlewares)
  }

  public func discoverMovie(_ params: DiscoverMovieRequestParams) -> AnyPublisher<DiscoverMovieResponse, ErrorResponse> {
    provider.execute(request: .discoverMovie(params: params))
  }
}
