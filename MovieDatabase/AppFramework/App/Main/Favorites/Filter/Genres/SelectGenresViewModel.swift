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
    public let selectedGenre: AnyPublisher<GenreItem, Never>

    public init(selectedGenre: AnyPublisher<GenreItem, Never>) {
      self.selectedGenre = selectedGenre
    }
  }

  public struct Output {
    public let values: AnyPublisher<[GenreItem], Never>

    public init(values: AnyPublisher<[GenreItem], Never>) {
      self.values = values
    }
  }

  public let transform: (Input) -> Output

  public init(
    transform: @escaping (Input) -> Output
  ) {
    self.transform = transform
  }

  public static func `default`(metadata: AnyPublisher<MetaData, Never>) -> SelectGenresViewModel {
    SelectGenresViewModel { input in
      let selectedGenres = input.selectedGenre
        .scan(Set<Genre>()) { acc, curr in
          var newSet = acc
          if acc.contains(curr.genre) {
            newSet.remove(curr.genre)
            return newSet
          } else {
            newSet.insert(curr.genre)
            return newSet
          }
        }
        .prepend(.init())

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

      return Output(
        values: values.eraseToAnyPublisher()
      )
    }
  }
}
