import Combine
import TheMovieDatabaseApi

private let mockImageUrl = URL(string: "https://m.media-amazon.com/images/M/MV5BMjAzYjhkN2UtM2U2Ny00MDE3LWE0OGItNDc5NGZkNjE2NWI5XkEyXkFqcGdeQXVyNzY1ODU1OTk@._V1_QL40_UX256_CR0,0,256,379_.jpg")!

public enum MoviesSection: Hashable {
  case main
}

public struct MoviesViewModel {
  public struct Input {
    public let refresh: AnyPublisher<Void, Never>
    public let nextPage: AnyPublisher<Void, Never>

    public init(
      refresh: AnyPublisher<Void, Never>,
      nextPage: AnyPublisher<Void, Never>
    ) {
      self.refresh = refresh
      self.nextPage = nextPage
    }
  }

  public struct Output {
    public let values: AnyPublisher<[MovieViewModel], Never>
    public let error: AnyPublisher<ErrorResponse, Never>
    public let isRefreshing: AnyPublisher<Bool, Never>

    public init(
      values: AnyPublisher<[MovieViewModel], Never>,
      error: AnyPublisher<ErrorResponse, Never>,
      isRefreshing: AnyPublisher<Bool, Never>
    ) {
      self.values = values
      self.error = error
      self.isRefreshing = isRefreshing
    }
  }

  public let transform: (Input) -> Output

  public init(_ transform: @escaping (Input) -> Output) {
    self.transform = transform
  }

  public static func `default`() -> MoviesViewModel {
    MoviesViewModel { input in
      let paginationSink = PaginationSink<DiscoverMovieResponse.Movie, ErrorResponse>.make(
        refreshTrigger: input.refresh,
        nextPageTrigger: input.nextPage,
        valuesFromEnvelope: { envelope in envelope.results },
        cursorFromEnvelope: { envelope in envelope.page },
        requestFromCursor: { page in Env.client.discoverMovie(DiscoverMovieRequestParams(page: page)) }
      )

      let value = paginationSink.values
        .map { movies in
          movies.map { movie in
            // TODO: Get baseUrl from config
            MovieViewModel(
              id: movie.id,
              title: movie.title,
              imageUrl: URL(string: "https://image.tmdb.org/t/p/w300\(movie.posterPath)")!,
              liked: false
            )
          }
        }

      return Output(
        values: value.eraseToAnyPublisher(),
        error: paginationSink.error,
        isRefreshing: paginationSink.isRefreshing
      )
    }
  }
}
