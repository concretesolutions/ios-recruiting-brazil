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
  public let year: String
  public let overview: String
  public let genres: [Int16]
  public let imageUrl: URL
  public let transform: (Input) -> Output

  public init(
    id: Int,
    title: String,
    year: String,
    overview: String,
    genres: [Int16],
    imageUrl: URL,
    transform: @escaping (Input) -> Output
  ) {
    self.id = id
    self.title = title
    self.year = year
    self.overview = overview
    self.genres = genres
    self.imageUrl = imageUrl
    self.transform = transform
  }

  public static func `default`(
    id: Int,
    title: String,
    year: String,
    overview: String,
    genres: [Int16],
    imageUrl: URL,
    repo: MOMovieRepo
  ) -> MovieViewModel {
    MovieViewModel(id: id, title: title, year: year, overview: overview, genres: genres, imageUrl: imageUrl) { input in
      var movie = repo.get(id)
      var currentLike = movie != nil

      let genreRepo = MOGenreRepo.default(moc: Env.database.moc)
      let moGenres = genres.compactMap { genreId in genreRepo.get(genreId) }

      // TODO: This logic can be improved. We probably don't need to
      // delete and save the context right after a click
      let like = input.like
        .scan(currentLike) { liked, _ in !liked }
        .prepend(currentLike)
        .handleEvents(receiveOutput: { liked in
          if liked {
            if movie == nil {
              movie = repo.create { movie in
                movie.id = Int64(id)
                movie.title = title
                movie.year = year
                movie.genres = Set(moGenres)
                movie.overview = overview
              }
            }
          } else {
            if let movieUnwrapped = movie {
              _ = repo.delete(movieUnwrapped)
              movie = nil
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
