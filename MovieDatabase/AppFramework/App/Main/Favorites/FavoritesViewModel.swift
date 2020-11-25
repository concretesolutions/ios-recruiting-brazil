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
    public let clearFilters: AnyPublisher<Void, Never>

    public init(
      refresh: AnyPublisher<Void, Never>,
      delete: AnyPublisher<IndexPath, Never>,
      searchText: AnyPublisher<String?, Never>,
      clearFilters: AnyPublisher<Void, Never>
    ) {
      self.refresh = refresh
      self.delete = delete
      self.searchText = searchText
      self.clearFilters = clearFilters
    }
  }

  public struct Output {
    public let filteredValues: AnyPublisher<[FavoriteViewModel], Never>
    public let filterOn: AnyPublisher<Bool, Never>
    public let cancellables: Set<AnyCancellable>

    public init(
      filteredValues: AnyPublisher<[FavoriteViewModel], Never>,
      filterOn: AnyPublisher<Bool, Never>,
      cancellables: Set<AnyCancellable>
    ) {
      self.filteredValues = filteredValues
      self.filterOn = filterOn
      self.cancellables = cancellables
    }
  }

  public let transform: (Input) -> Output

  public init(transform: @escaping (Input) -> Output) {
    self.transform = transform
  }

  public static func `default`(
    repo: MovieRepo = .default(moc: Env.database.moc),
    dateFilter: CurrentValueSubject<String?, Never>,
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

      let filteredValues = Publishers.CombineLatest4(input.searchText, genresFilter, dateFilter, values)
        .map { searchText, genresToFilter, dateToFilter, favoriteViewModels -> [FavoriteViewModel] in
          var filters = [Filter<Movie>]()

          if let searchText = searchText, !searchText.isEmpty {
            let filterByTitle = Filters.movieFilter(byTitle: searchText)
            filters.append(filterByTitle)
          }

          if let dateToFilter = dateToFilter, dateToFilter.count > 0 {
            let filterByDate = Filters.movieFilter(byYear: dateToFilter)
            filters.append(filterByDate)
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

      let filterOn = Publishers.CombineLatest(
        genresFilter, dateFilter
      )
      .map { genres, date in
        genres.count > 0 || (date ?? "").count > 0
      }

      var cancellables = Set<AnyCancellable>()

      input.clearFilters
        .sink(receiveValue: {
          genresFilter.send(.init())
          dateFilter.send(nil)
        })
        .store(in: &cancellables)

      return Output(
        filteredValues: filteredValues.share().eraseToAnyPublisher(),
        filterOn: filterOn.eraseToAnyPublisher(),
        cancellables: cancellables
      )
    }
  }
}
