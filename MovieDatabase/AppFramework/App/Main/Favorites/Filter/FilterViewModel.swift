import Combine

public enum FilterSection: Hashable {
  case main
  case apply
}

public enum FilterItem: Hashable, Equatable {
  public func hash(into hasher: inout Hasher) {
    switch self {
    case .date: hasher.combine("date")
    case .genres: hasher.combine("genres")
    case .apply: hasher.combine("apply")
    }
  }

  public static func == (lhs: FilterItem, rhs: FilterItem) -> Bool {
    switch (lhs, rhs) {
    case (.apply, .apply): return true
    case (.date, .date): return true
    case (.genres, .genres): return true
    default: return false
    }
  }

  case date(CurrentValueSubject<String?, Never>)
  case genres(AnyPublisher<String, Never>)
  case apply(PassthroughSubject<Void, Never>)
}

public struct FilterViewModel {
  public struct Output {
    public let currentDate: CurrentValueSubject<String?, Never>
    public let genreDetails: AnyPublisher<String, Never>
    public let apply: PassthroughSubject<Void, Never>
    public let applyError: AnyPublisher<(String, String)?, Never>
    public let cancellables: Set<AnyCancellable>

    public init(
      currentDate: CurrentValueSubject<String?, Never>,
      genreDetails: AnyPublisher<String, Never>,
      apply: PassthroughSubject<Void, Never>,
      applyError: AnyPublisher<(String, String)?, Never>,
      cancellables: Set<AnyCancellable>
    ) {
      self.currentDate = currentDate
      self.genreDetails = genreDetails
      self.apply = apply
      self.applyError = applyError
      self.cancellables = cancellables
    }
  }

  public let transform: () -> Output

  public static func `default`(
    currentSelectedGenres: CurrentValueSubject<Set<Genre>, Never>,
    dateFilter: CurrentValueSubject<String?, Never>,
    genresFilter: CurrentValueSubject<Set<Genre>, Never>
  ) -> FilterViewModel {
    FilterViewModel {
      var cancellables = Set<AnyCancellable>()

      let genresDetails = currentSelectedGenres
        .map { "\($0.count)" }

      let apply = PassthroughSubject<Void, Never>()
      let currentDate = CurrentValueSubject<String?, Never>(dateFilter.value)

      apply
        .map { currentDate.value }
        .subscribe(dateFilter)
        .store(in: &cancellables)

      apply
        .map { currentSelectedGenres.value }
        .subscribe(genresFilter)
        .store(in: &cancellables)

      // Sends an error message or nil if no error
      let applyError = apply
        .map {
          currentDate.value
        }
        .map { year -> (String, String)? in
          guard let year = year, year.count > 0 else { return nil } // No filter applied
          guard let intYear = Int(year) else {
            return (L10n.Screen.Favorites.Filter.InvalidYearError.title, L10n.Screen.Favorites.Filter.InvalidYearError.onlyNumbers)
          }
          guard intYear >= 1874 else {
            return (L10n.Screen.Favorites.Filter.InvalidYearError.title, L10n.Screen.Favorites.Filter.InvalidYearError.greaterThan1874)
          }
          return nil
        }

      return Output(
        currentDate: currentDate,
        genreDetails: genresDetails.eraseToAnyPublisher(),
        apply: apply,
        applyError: applyError.eraseToAnyPublisher(),
        cancellables: cancellables
      )
    }
  }
}
