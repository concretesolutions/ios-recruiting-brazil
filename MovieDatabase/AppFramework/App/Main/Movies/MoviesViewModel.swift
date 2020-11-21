import Combine
import TheMovieDatabaseApi

private extension DiscoverMovieResponse.Movie {
  func year() -> String {
    String(
      releaseDate
        .split(separator: "-")
        .first(where: { $0.count == 4 }) ?? "????"
    )
  }
}

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

  public static func `default`(
    movieRepo: MOMovieRepo = MOMovieRepo.default(moc: Env.database.moc),
    metaData: AnyPublisher<MetaData, Never>
  ) -> MoviesViewModel {
    MoviesViewModel { input in
      let paginationSink = PaginationSink<DiscoverMovieResponse.Movie, ErrorResponse>.make(
        refreshTrigger: input.refresh,
        nextPageTrigger: input.nextPage,
        valuesFromEnvelope: { envelope in envelope.results },
        cursorFromEnvelope: { envelope in envelope.page },
        requestFromCursor: { page in Env.client.discoverMovie(DiscoverMovieRequestParams(page: page)) }
      )

      let value = Publishers.CombineLatest(
        paginationSink.values.share(),
        metaData
      )
      .map { movies, metaData -> [MovieViewModel] in
        let imageBaseUrl = metaData.configuration?.urlForSmallImage() ?? Constants.fallbackImageBaseUrl
        return movies.map { movie in
          MovieViewModel.default(
            id: movie.id,
            title: movie.title,
            year: movie.year(),
            overview: movie.overview,
            genres: movie.genreIds,
            imageUrl: imageBaseUrl.appendingPathComponent(movie.posterPath),
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
