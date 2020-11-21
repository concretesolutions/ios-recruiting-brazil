import Combine

public final class TMDClient {
  public typealias ResponsePublisher<T> = AnyPublisher<Result<T, ErrorResponse>, Never>

  private let provider: Provider

  public init(session: Session, baseUrl: URL, middlewares: [Middleware]) {
    provider = Provider(session: session, baseUrl: baseUrl, middlewares: middlewares)
  }

  public func discoverMovie(_ params: DiscoverMovieRequestParams) -> ResponsePublisher<DiscoverMovieResponse> {
    provider.executeWithResult(request: .discoverMovie(params: params))
  }

  public func genres() -> ResponsePublisher<GenresResponse> {
    provider.executeWithResult(request: .genres())
  }
}
