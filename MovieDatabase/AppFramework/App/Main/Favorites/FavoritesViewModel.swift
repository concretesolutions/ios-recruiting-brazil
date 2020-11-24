import Combine
import CoreData

public enum FavoritesSection: Hashable {
  case main
}

public struct FavoritesViewModel {
  public struct Input {
    public let refresh: AnyPublisher<Void, Never>
    public let delete: AnyPublisher<IndexPath, Never>
    public let searchText: AnyPublisher<String?, Never>

    public init(
      refresh: AnyPublisher<Void, Never>,
      delete: AnyPublisher<IndexPath, Never>,
      searchText: AnyPublisher<String?, Never>
    ) {
      self.refresh = refresh
      self.delete = delete
      self.searchText = searchText
    }
  }

  public struct Output {
    public let filteredValues: AnyPublisher<[FavoriteViewModel], Never>

    public init(
      filteredValues: AnyPublisher<[FavoriteViewModel], Never>
    ) {
      self.filteredValues = filteredValues
    }
  }

  public let transform: (Input) -> Output

  public init(transform: @escaping (Input) -> Output) {
    self.transform = transform
  }

  public static func `default`(
    repo: MovieRepo = .default(moc: Env.database.moc),
    genresFilter: CurrentValueSubject<Set<Genre>, Never>
  ) -> FavoritesViewModel {
    FavoritesViewModel { input in

      // We can improve this logic by watching the Notification with name NSManagedObjectContextDidSave
      // and only make changes when needed instead of always reloading all Movies
      let values = input.refresh
        .map { _ in
          Just<[FavoriteViewModel]>(
            repo.getAll()
              .map(FavoriteViewModel.init(movie:))
          )
          .combineLatest(
            input.delete.prepend(IndexPath(row: -1, section: -1))
          )
          .scan([FavoriteViewModel]()) { acc, curr -> [FavoriteViewModel] in
            guard acc.count > 0 else {
              return curr.0
            }

            guard curr.1.row > -1 else {
              return acc
            }

            let rowToDelete = curr.1.row
            let viewModelToDelete = acc[curr.1.row]

            var newValues = acc
            if repo.delete(viewModelToDelete.movie) {
              newValues.remove(at: rowToDelete)
            }
            return newValues
          }
        }
        .switchToLatest()

      let filteredValues = Publishers.CombineLatest3(input.searchText, genresFilter, values)
        .map { searchText, genresToFilter, favoriteViewModels -> [FavoriteViewModel] in
          var filters = [Filter<Movie>]()

          if let searchText = searchText, !searchText.isEmpty {
            let filterByTitle = Filters.movieFilter(byTitle: searchText)
            filters.append(filterByTitle)
          }

          if genresToFilter.count > 0 {
            let filterByGenre = Filters.movieFilter(byGenreIds: genresToFilter.map(\.id))
            filters.append(filterByGenre)
          }

          let emptyFilter = Filter<Movie> { _ in true }

          let filter = filters.reduce(emptyFilter) { acc, curr in
            acc.merge(with: curr, strategy: .and)
          }
          .contramap { (favoriteViewModel: FavoriteViewModel) in
            favoriteViewModel.movie
          }

          return filter.runFilter(favoriteViewModels)
        }

      return Output(
        filteredValues: filteredValues.eraseToAnyPublisher()
      )
    }
  }
}
