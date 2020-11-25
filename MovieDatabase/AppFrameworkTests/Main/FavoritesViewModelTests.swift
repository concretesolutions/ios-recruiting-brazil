import AppFramework
import Combine
import TestSupport
import TheMovieDatabaseApi
import XCTest

final class FavoritesViewModelTests: XCTestCase {
  func testDefaultFavoritesViewModel_Delete() {
    let repo = MovieRepo.inMemmoryMock(movies: [
      .stub(id: 0),
      .stub(id: 1),
      .stub(id: 2),
    ])

    assertFavoritesViewModel(
      movieRepo: repo,
      commands: { input in
        input.refresh.send(())
        input.delete.send(.stubMovie(id: 1))
        input.delete.send(.stubMovie(id: 2))
        input.refresh.send(())
        input.delete.send(.stubMovie(id: 0))
      },
      assertions: [
        .filterOn(false),
        // Refresh
        .filteredValues([
          .stubMovie(id: 0),
          .stubMovie(id: 1),
          .stubMovie(id: 2),
        ]),
        // Delete id = 1
        .filteredValues([
          .stubMovie(id: 0),
          .stubMovie(id: 2),
        ]),
        // Delete id = 2
        .filteredValues([
          .stubMovie(id: 0),
        ]),
        // Refresh
        // -- No changes
        // Delete id = 0
        .filteredValues([]),
      ]
    )
  }

  func testDefaultFavoritesViewModel_Filtering() {
    let repo = MovieRepo.inMemmoryMock(movies: [
      .stub(id: 0, title: "a", year: "2020", genreIds: [0, 5]),
      .stub(id: 1, title: "ab", year: "2020", genreIds: [1, 4]),
      .stub(id: 2, title: "abc", year: "2010", genreIds: [2, 3]),
      .stub(id: 3, title: "abcd", year: "2010", genreIds: [3, 2]),
      .stub(id: 4, title: "abcde", year: "2000", genreIds: [4, 1]),
    ])

    assertFavoritesViewModel(
      movieRepo: repo,
      commands: { input in
        input.refresh.send(())
        input.dateFilter.send("2020")
        input.genresFilter.send(Set([
          Genre(id: 1, name: ""),
        ]))
        input.searchText.send("e")
        input.clearFilters.send(())
        input.delete.send(.stubMovie(id: 4, title: "abcde", year: "2000", genreIds: [4, 1]))
      },
      assertions: [
        .filterOn(false),
        // Refresh
        .filteredValues([
          .stubMovie(id: 0, title: "a", year: "2020", genreIds: [0, 5]),
          .stubMovie(id: 1, title: "ab", year: "2020", genreIds: [1, 4]),
          .stubMovie(id: 2, title: "abc", year: "2010", genreIds: [2, 3]),
          .stubMovie(id: 3, title: "abcd", year: "2010", genreIds: [3, 2]),
          .stubMovie(id: 4, title: "abcde", year: "2000", genreIds: [4, 1]),
        ]),
        // Add filter by date 2020
        // FIXME: Workaround - using filteredValuesOrFilterOn twice because some times
        // filterOn comes before filteredValues
        .filteredValuesOrFilterOn([
          .stubMovie(id: 0, title: "a", year: "2020", genreIds: [0, 5]),
          .stubMovie(id: 1, title: "ab", year: "2020", genreIds: [1, 4]),
        ], true),
        .filteredValuesOrFilterOn([
          .stubMovie(id: 0, title: "a", year: "2020", genreIds: [0, 5]),
          .stubMovie(id: 1, title: "ab", year: "2020", genreIds: [1, 4]),
        ], true),
        // Add filter by genres [1]
        .filteredValues([
          .stubMovie(id: 1, title: "ab", year: "2020", genreIds: [1, 4]),
        ]),
        // Add filter search text "e"
        .filteredValues([]),
        // Clear filters
        // FIXME: Workaround - using filteredValuesOrFilterOn twice because some times
        // filterOn comes before filteredValues
        .filteredValuesOrFilterOn([
          .stubMovie(id: 4, title: "abcde", year: "2000", genreIds: [4, 1]),
        ], false),
        .filteredValuesOrFilterOn([
          .stubMovie(id: 4, title: "abcde", year: "2000", genreIds: [4, 1]),
        ], false),
        // Remove movie with id 4
        .filteredValues([]),
      ]
    )
  }
}

private enum FavoritesEvent: Equatable {
  static func == (lhs: FavoritesEvent, rhs: FavoritesEvent) -> Bool {
    switch (lhs, rhs) {
    case let (.filteredValues(l), .filteredValues(r)): return l == r
    case let (.filterOn(l), .filterOn(r)): return l == r
    case let (.filteredValuesOrFilterOn(l1, l2), .filteredValuesOrFilterOn(r1, r2)): return l1 == r1 && l2 == r2

    // FIXME: This is here because some times filterOn event comes before the filteredValues event
    case let (.filteredValuesOrFilterOn(lv, _), .filteredValues(rv)): return lv == rv
    case let (.filteredValues(lv), .filteredValuesOrFilterOn(rv, _)): return lv == rv
    case let (.filteredValuesOrFilterOn(_, lf), .filterOn(rf)): return lf == rf
    case let (.filterOn(lf), .filteredValuesOrFilterOn(_, rf)): return lf == rf

    default: return false
    }
  }

  case filteredValues([FavoriteViewModel])
  case filterOn(Bool)
  case filteredValuesOrFilterOn([FavoriteViewModel], Bool)
}

private struct FavoritesViewModelTestsInput {
  let refresh = PassthroughSubject<Void, Never>()
  let delete = PassthroughSubject<FavoriteViewModel?, Never>()
  let searchText = CurrentValueSubject<String?, Never>(nil)
  let clearFilters = PassthroughSubject<Void, Never>()

  let dateFilter = CurrentValueSubject<String?, Never>(nil)
  let genresFilter = CurrentValueSubject<Set<Genre>, Never>(.init())
}

private func assertFavoritesViewModel(
  file: StaticString = #file,
  line: UInt = #line,
  movieRepo: MovieRepo,
  commands: @escaping (FavoritesViewModelTestsInput) -> Void,
  assertions: [FavoritesEvent]
) {
  var cancellables = Set<AnyCancellable>()

  let input = FavoritesViewModelTestsInput()

  let viewModel = FavoritesViewModel.default(
    repo: movieRepo,
    dateFilter: input.dateFilter,
    genresFilter: input.genresFilter
  )

  let output = viewModel.transform(
    .init(
      refresh: input.refresh.eraseToAnyPublisher(),
      delete: input.delete.eraseToAnyPublisher(),
      searchText: input.searchText.eraseToAnyPublisher(),
      clearFilters: input.clearFilters.eraseToAnyPublisher()
    )
  )

  cancellables.formUnion(output.cancellables)

  let publisher = Publishers.Merge(
    output.filteredValues.map(FavoritesEvent.filteredValues),
    output.filterOn.map(FavoritesEvent.filterOn)
  )

  assertPublisherEvents(
    file: file,
    line: line,
    publisher: publisher.eraseToAnyPublisher(),
    trigger: { commands(input) },
    assertions: assertions
  )
}
