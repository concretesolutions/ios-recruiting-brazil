import Combine

public struct MovieViewModel: Identifiable, Hashable {
  public static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
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

  public let id: Int
  public let title: String
  public let imageUrl: URL
  public let transform: (Input) -> Output

  public init(
    id: Int,
    title: String,
    imageUrl: URL,
    transform: @escaping (Input) -> Output
  ) {
    self.id = id
    self.title = title
    self.imageUrl = imageUrl
    self.transform = transform
  }

  public static func `default`(
    id: Int,
    title: String,
    imageUrl: URL,
    repo: MOMovieRepo
  ) -> MovieViewModel {
    MovieViewModel(id: id, title: title, imageUrl: imageUrl) { input in
      var movie = repo.get(id)
      var currentLike = movie != nil

      // TODO: This logic can be improved. We probably don't need to
      // delete and save the context right after a click
      let like = input.like
        .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
        .scan(currentLike) { liked, _ in !liked }
        .prepend(currentLike)
        .handleEvents(receiveOutput: { liked in
          if liked {
            if movie == nil {
              movie = repo.create { movie in
                movie.id = Int64(id)
                movie.title = title
                movie.overview = "Hello 123"
              }
            }
          } else {
            if let movie = movie {
              repo.delete(movie)
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
