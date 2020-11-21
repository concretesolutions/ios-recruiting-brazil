import Combine

public enum FavoritesSection: Hashable {
  case main
}

public struct FavoriteViewModel: Identifiable, Hashable {
  public let id: Int64
  public let title: String
  public let overview: String

  public init(
    id: Int64,
    title: String,
    overview: String
  ) {
    self.id = id
    self.title = title
    self.overview = overview
  }
}

public struct FavoritesViewModel {
  public struct Input {
    public let refresh: AnyPublisher<Void, Never>

    public init(
      refresh: AnyPublisher<Void, Never>
    ) {
      self.refresh = refresh
    }
  }

  public struct Output {
    public let values: AnyPublisher<[FavoriteViewModel], Never>

    public init(
      values: AnyPublisher<[FavoriteViewModel], Never>
    ) {
      self.values = values
    }
  }

  public let transform: (Input) -> Output

  public init(transform: @escaping (Input) -> Output) {
    self.transform = transform
  }

  public static func `default`(repo: MOMovieRepo = .default(moc: Env.database.moc)) -> FavoritesViewModel {
    FavoritesViewModel { input in
      let values = input.refresh
        .map { _ in
          repo.getAll()
            .map { movie in
              FavoriteViewModel(
                id: movie.id,
                title: movie.title,
                overview: movie.overview
              )
            }
        }

      return Output(
        values: values.eraseToAnyPublisher()
      )
    }
  }
}
