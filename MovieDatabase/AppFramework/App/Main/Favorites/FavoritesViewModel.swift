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
    public let values: AnyPublisher<[FavoriteViewModel], Never>
    public let filteredValues: AnyPublisher<[FavoriteViewModel], Never>

    public init(
      values: AnyPublisher<[FavoriteViewModel], Never>,
      filteredValues: AnyPublisher<[FavoriteViewModel], Never>
    ) {
      self.values = values
      self.filteredValues = filteredValues
    }
  }

  public let transform: (Input) -> Output

  public init(transform: @escaping (Input) -> Output) {
    self.transform = transform
  }

  public static func `default`(repo: MovieRepo = .default(moc: Env.database.moc)) -> FavoritesViewModel {
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
        .share()

      let filteredValues = Publishers.CombineLatest(input.searchText, values)
        .map { searchText, favoriteViewModels -> [FavoriteViewModel] in
          guard let searchText = searchText, !searchText.isEmpty else {
            return []
          }
          let strippedString = searchText.trimmingCharacters(in: .whitespaces)
          let searchItems = strippedString.components(separatedBy: " ") as [String]
          let predicates = searchItems.map(predicates(for:))
          let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
          return favoriteViewModels.filter { predicate.evaluate(with: $0.movie.title) }
        }

      return Output(
        values: values.eraseToAnyPublisher(),
        filteredValues: filteredValues.eraseToAnyPublisher()
      )
    }
  }
}

private func predicates(for searchString: String) -> NSComparisonPredicate {
  let titleExpression = NSExpression(
    block: { value, _, _ in
      value!
    },
    arguments: nil
  )
  let searchStringExpression = NSExpression(forConstantValue: searchString)

  let titleSearchComparisonPredicate = NSComparisonPredicate(
    leftExpression: titleExpression,
    rightExpression: searchStringExpression,
    modifier: .direct,
    type: .contains,
    options: [.caseInsensitive, .diacriticInsensitive]
  )

  return titleSearchComparisonPredicate
}
