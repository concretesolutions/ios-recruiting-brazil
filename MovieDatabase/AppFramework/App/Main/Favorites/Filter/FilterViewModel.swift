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

  case date(AnyPublisher<String, Never>)
  case genres(AnyPublisher<String, Never>)
  case apply(PassthroughSubject<Void, Never>)
}

public struct FilterViewModel {
  public struct Output {
    public let dateDetails: AnyPublisher<String, Never>
    public let genreDetails: AnyPublisher<String, Never>
    public let apply: PassthroughSubject<Void, Never>
    public let cancellables: Set<AnyCancellable>

    public init(
      dateDetails: AnyPublisher<String, Never>,
      genreDetails: AnyPublisher<String, Never>,
      apply: PassthroughSubject<Void, Never>,
      cancellables: Set<AnyCancellable>
    ) {
      self.dateDetails = dateDetails
      self.genreDetails = genreDetails
      self.apply = apply
      self.cancellables = cancellables
    }
  }

  public let transform: () -> Output

  public static func `default`(
    currentSelectedGenres: CurrentValueSubject<Set<Genre>, Never>,
    genresFilter: CurrentValueSubject<Set<Genre>, Never>
  ) -> FilterViewModel {
    FilterViewModel {
      var cancellables = Set<AnyCancellable>()

      let apply = PassthroughSubject<Void, Never>()

      let dateDetails = Empty<String, Never>(completeImmediately: false)
      let genresDetails = currentSelectedGenres
        .map { "\($0.count)" }

      apply
        .map { currentSelectedGenres.value }
        .subscribe(genresFilter)
        .store(in: &cancellables)

      return Output(
        dateDetails: dateDetails.eraseToAnyPublisher(),
        genreDetails: genresDetails.eraseToAnyPublisher(),
        apply: apply,
        cancellables: cancellables
      )
    }
  }
}
