import Combine
import TheMovieDatabaseApi

private let mockImageUrl = URL(string: "https://m.media-amazon.com/images/M/MV5BMjAzYjhkN2UtM2U2Ny00MDE3LWE0OGItNDc5NGZkNjE2NWI5XkEyXkFqcGdeQXVyNzY1ODU1OTk@._V1_QL40_UX256_CR0,0,256,379_.jpg")!

public struct MoviesViewModel {
  public enum Section: Hashable {
    case main
  }

  public init() {}

  public func setupBindings(
    refresh: AnyPublisher<Void, Never>,
    nextPage: AnyPublisher<Void, Never>
  ) -> (
    values: AnyPublisher<[MovieViewModel], Never>,
    error: AnyPublisher<ErrorResponse, Never>,
    isRefreshing: AnyPublisher<Bool, Never>
  ) {
    let paginationSink = PaginationSink<DiscoverMovieResponse.Movie, ErrorResponse>.make(
      refreshTrigger: refresh,
      nextPageTrigger: nextPage,
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

    return (
      value.eraseToAnyPublisher(),
      paginationSink.error,
      paginationSink.isRefreshing
    )
  }
}
