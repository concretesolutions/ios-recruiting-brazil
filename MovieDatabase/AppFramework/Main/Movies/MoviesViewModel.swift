import Combine

private let movies = [
  MovieViewModel(
    id: 1,
    title: "Thor",
    imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMjAzYjhkN2UtM2U2Ny00MDE3LWE0OGItNDc5NGZkNjE2NWI5XkEyXkFqcGdeQXVyNzY1ODU1OTk@._V1_QL40_UX256_CR0,0,256,379_.jpg")!,
    liked: false
  ),
  MovieViewModel(
    id: 2,
    title: "Thor 2",
    imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMjAzYjhkN2UtM2U2Ny00MDE3LWE0OGItNDc5NGZkNjE2NWI5XkEyXkFqcGdeQXVyNzY1ODU1OTk@._V1_QL40_UX256_CR0,0,256,379_.jpg")!,
    liked: false
  ),
  MovieViewModel(
    id: 3,
    title: "Thor 3",
    imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMjAzYjhkN2UtM2U2Ny00MDE3LWE0OGItNDc5NGZkNjE2NWI5XkEyXkFqcGdeQXVyNzY1ODU1OTk@._V1_QL40_UX256_CR0,0,256,379_.jpg")!,
    liked: false
  ),
  MovieViewModel(
    id: 4,
    title: "Thor 4",
    imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMjAzYjhkN2UtM2U2Ny00MDE3LWE0OGItNDc5NGZkNjE2NWI5XkEyXkFqcGdeQXVyNzY1ODU1OTk@._V1_QL40_UX256_CR0,0,256,379_.jpg")!,
    liked: false
  ),
  MovieViewModel(
    id: 5,
    title: "Thor 5",
    imageUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMjAzYjhkN2UtM2U2Ny00MDE3LWE0OGItNDc5NGZkNjE2NWI5XkEyXkFqcGdeQXVyNzY1ODU1OTk@._V1_QL40_UX256_CR0,0,256,379_.jpg")!,
    liked: false
  ),
]

private func loadMovies() -> AnyPublisher<[MovieViewModel], Never> {
  Deferred {
    Future { promise in
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        promise(.success(movies))
      }
    }
  }
  .eraseToAnyPublisher()
}

public struct MoviesViewModel {
  public enum Section: Hashable {
    case main
  }

  public func setupBindings(
    refresh: AnyPublisher<Void, Never>
  ) -> AnyPublisher<[MovieViewModel], Never> {
    let load = Publishers.Merge(Just<Void>(()), refresh)

    let movies = load
      .flatMap(maxPublishers: .max(1)) { loadMovies() }
      .eraseToAnyPublisher()

    return movies
  }
}
