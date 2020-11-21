import Combine
import TheMovieDatabaseApi

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

  public static func `default`(movieRepo: MOMovieRepo = MOMovieRepo.default(moc: Env.database.moc)) -> MoviesViewModel {
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
            MovieViewModel.default(
              id: movie.id,
              title: movie.title,
              imageUrl: URL(string: "https://image.tmdb.org/t/p/w300\(movie.posterPath)")!,
              repo: movieRepo
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
