import Combine

public struct FavoriteViewModel: Hashable {
  let uuid = UUID()
}

public struct FavoritesViewModel {
  public struct Input {
    public init() {}
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

  public static func `default`() -> FavoritesViewModel {
    FavoritesViewModel { _ in
      Output(values: Just<[FavoriteViewModel]>(
        [
          FavoriteViewModel(),
          FavoriteViewModel(),
          FavoriteViewModel(),
        ]
      )
      .eraseToAnyPublisher())
    }
  }
}
