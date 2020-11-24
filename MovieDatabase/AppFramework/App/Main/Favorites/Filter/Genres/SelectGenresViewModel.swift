import Combine

public enum GenreSection: Hashable {
  case main
}

public struct GenreItem: Hashable {
  public let genre: Genre
  public let selected: Bool

  public init(
    genre: Genre,
    selected: Bool
  ) {
    self.genre = genre
    self.selected = selected
  }
}

public struct SelectGenresViewModel {
  public struct Input {
    public let clear: AnyPublisher<Void, Never>
    public let selectedGenre: AnyPublisher<GenreItem, Never>

    public init(
      clear: AnyPublisher<Void, Never>,
      selectedGenre: AnyPublisher<GenreItem, Never>
    ) {
      self.clear = clear
      self.selectedGenre = selectedGenre
    }
  }

  public struct Output {
    public let values: AnyPublisher<[GenreItem], Never>
    public let cancellables: Set<AnyCancellable>

    public init(
      values: AnyPublisher<[GenreItem], Never>,
      cancellables: Set<AnyCancellable>
    ) {
      self.values = values
      self.cancellables = cancellables
    }
  }

  public let transform: (Input) -> Output

  public init(
    transform: @escaping (Input) -> Output
  ) {
    self.transform = transform
  }

  public static func `default`(
    metadata: AnyPublisher<MetaData, Never>,
    currentSelectedGenres: CurrentValueSubject<Set<Genre>, Never>
  ) -> SelectGenresViewModel {
    SelectGenresViewModel { input in
      var cancellables = Set<AnyCancellable>()

      let selectedGenres = Publishers.Merge(
        input.clear.map { _ -> GenreItem? in .none },
        input.selectedGenre.map { genreItem -> GenreItem? in genreItem }
      )
      .scan(currentSelectedGenres.value) { acc, curr in
        guard let curr = curr else {
          return .init()
        }

        var newSet = acc
        if acc.contains(curr.genre) {
          newSet.remove(curr.genre)
          return newSet
        } else {
          newSet.insert(curr.genre)
          return newSet
        }
      }
      .multicast(subject: CurrentValueSubject<Set<Genre>, Never>(currentSelectedGenres.value))

      selectedGenres
        .subscribe(currentSelectedGenres)
        .store(in: &cancellables)

      let values = metadata
        .combineLatest(selectedGenres)
        .map { args -> [GenreItem] in
          let (metadata, selectedGenres) = args
          let genres = metadata.genres ?? []
          return genres.map { genre in
            GenreItem(
              genre: genre,
              selected: selectedGenres.contains(genre)
            )
          }
        }
        .share()

      selectedGenres
        .connect()
        .store(in: &cancellables)

      return Output(
        values: values.eraseToAnyPublisher(),
        cancellables: cancellables
      )
    }
  }
}
