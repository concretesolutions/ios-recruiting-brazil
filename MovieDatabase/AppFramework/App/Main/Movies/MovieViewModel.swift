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
    public let refresh: AnyPublisher<Void, Never>

    public init(
      like: AnyPublisher<Void, Never>,
      refresh: AnyPublisher<Void, Never>
    ) {
      self.like = like
      self.refresh = refresh
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
      // TODO: This logic can be improved. We probably don't need to
      // delete and save the context right after a click
      let like = input.refresh
        .prepend(())
        .map { _ -> AnyPublisher<Bool, Never> in
          let initialLiked = repo.get(movie.id) != nil
          return input.like
            .scan(initialLiked) { liked, _ in !liked }
            .handleEvents(receiveOutput: { liked in
              if liked {
                _ = repo.create(movie)
              } else {
                _ = repo.delete(movie)
              }
            })
            .prepend(initialLiked)
            .eraseToAnyPublisher()
        }
        .switchToLatest()

      return Output(
        like: like.eraseToAnyPublisher()
      )
    }
  }
}
