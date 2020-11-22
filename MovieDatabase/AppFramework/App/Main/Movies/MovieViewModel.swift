import Combine

public struct MovieViewModel: Identifiable, Hashable {
  public static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
    lhs.movie.id == rhs.movie.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(movie.id)
  }

  public struct Input {
    public let like: AnyPublisher<Void, Never>

    public init(
      like: AnyPublisher<Void, Never>
    ) {
      self.like = like
    }
  }

  public struct Output {
    public let like: AnyPublisher<Bool, Never>

    public init(like: AnyPublisher<Bool, Never>) {
      self.like = like
    }
  }

  public let movie: Movie
  public var id: Int64 { movie.id }
  public let transform: (Input) -> Output

  public init(
    movie: Movie,
    transform: @escaping (Input) -> Output
  ) {
    self.movie = movie
    self.transform = transform
  }

  public static func `default`(
    movie: Movie,
    repo: MovieRepo
  ) -> MovieViewModel {
    MovieViewModel(movie: movie) { input in
      var _moMovie = repo.get(movie.id)
      var currentLike = _moMovie != nil

      // TODO: This logic can be improved. We probably don't need to
      // delete and save the context right after a click
      let like = input.like
        .scan(currentLike) { liked, _ in !liked }
        .prepend(currentLike)
        .handleEvents(receiveOutput: { liked in
          if liked {
            if _moMovie == nil {
              _moMovie = repo.create(movie)
            }
          } else {
            if let movieUnwrapped = _moMovie {
              _ = repo.delete(movieUnwrapped)
              _moMovie = nil
            }
          }
          currentLike = liked
        })

      return Output(
        like: like.eraseToAnyPublisher()
      )
    }
  }
}
