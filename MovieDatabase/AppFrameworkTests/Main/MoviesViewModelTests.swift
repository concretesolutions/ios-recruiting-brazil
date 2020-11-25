import AppFramework
import Combine
import TestSupport
import TheMovieDatabaseApi
import XCTest

final class MoviesViewModelTests: XCTestCase {
  func testDefaultViewModel_RequestError() {
    let movieRepo = MovieRepo.mock()
    let error = URLError(.badServerResponse)

    withEnvironment(
      client: .mock(with: error),
      notificationCenter: .init()
    ) {
      assertMoviesViewModel(
        movieRepo: movieRepo,
        metadata: .stub(configuration: .stub()),
        commands: { input in
          input.refresh.send(())
        },
        assertions: [
          .isRefreshing(false),
          .isRefreshing(true),
          .isRefreshing(false),
          .error(.stub(urlError: error)),
        ]
      )
    }
  }

  func testDefaultViewModel_NextPageAndSearch() throws {
    let movieRepo = MovieRepo.mock()
    let responses: [MoviePopularResponse] = [
      .stub(results: [
        .stub(id: 0, title: "a"),
        .stub(id: 1, title: "b"),
      ]),
      .stub(results: [
        .stub(id: 2, title: "ab"),
      ]),
    ]
    let responsesData = try responses.map { try $0.toData() }
    let results = responsesData.map {
      (data: $0, response: HTTPURLResponse(url: TestConstants.exampleUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!)
    }
    let client = TMDClient.mock(with: results)

    withEnvironment(
      client: client,
      notificationCenter: .init()
    ) {
      assertMoviesViewModel(
        movieRepo: movieRepo,
        metadata: .stub(configuration: .stub()),
        commands: { input in
          input.refresh.send(())
          input.nextPage.send(())
          input.searchText.send("a")
          input.searchText.send("ab")
        },
        assertions: [
          .isRefreshing(false),
          // Refresh
          .isRefreshing(true),
          .isRefreshing(false),
          // FIXME: Workaround - using valuesOrFiltered twice because some times
          // filtered event comes before the value event
          .valuesOrFiltered([
            .stub(movie: .stub(id: 0, title: "a")),
            .stub(movie: .stub(id: 1, title: "b")),
          ], []),
          .valuesOrFiltered([
            .stub(movie: .stub(id: 0, title: "a")),
            .stub(movie: .stub(id: 1, title: "b")),
          ], []),
          // Next Page
          .isRefreshing(true),
          .isRefreshing(false),
          // FIXME: Workaround - using valuesOrFiltered twice because some times
          // filtered event comes before the value event
          .valuesOrFiltered([
            .stub(movie: .stub(id: 0, title: "a")),
            .stub(movie: .stub(id: 1, title: "b")),
            .stub(movie: .stub(id: 2, title: "ab")),
          ], []),
          .valuesOrFiltered([
            .stub(movie: .stub(id: 0, title: "a")),
            .stub(movie: .stub(id: 1, title: "b")),
            .stub(movie: .stub(id: 2, title: "ab")),
          ], []),
          // Filtering
          .filteredValues([
            .stub(movie: .stub(id: 0, title: "a")),
            .stub(movie: .stub(id: 2, title: "ab")),
          ]),
          .filteredValues([
            .stub(movie: .stub(id: 2, title: "ab")),
          ]),
        ]
      )
    }
  }
}

private enum MoviesEvent: Equatable {
  static func == (lhs: MoviesEvent, rhs: MoviesEvent) -> Bool {
    switch (lhs, rhs) {
    case let (.values(l), .values(r)): return l == r
    case let (.filteredValues(l), .filteredValues(r)): return l == r
    case let (.valuesOrFiltered(lv, lf), .valuesOrFiltered(rv, rf)): return lv == rv && lf == rf
    case let (.error(l), .error(r)): return l == r
    case let (.isRefreshing(l), .isRefreshing(r)): return l == r

    // FIXME: This is here because some times filtered event comes before the value event
    case let (.valuesOrFiltered(lv, _), .values(r)): return lv == r
    case let (.values(l), .valuesOrFiltered(rv, _)): return l == rv
    case let (.valuesOrFiltered(_, lf), .filteredValues(r)): return lf == r
    case let (.filteredValues(l), .valuesOrFiltered(_, rf)): return l == rf

    default: return false
    }
  }

  case values([MovieViewModel])
  case filteredValues([MovieViewModel])
  case valuesOrFiltered([MovieViewModel], [MovieViewModel])
  case error(ErrorResponse)
  case isRefreshing(Bool)
}

private struct MoviesViewModelTestsInput {
  let refresh = PassthroughSubject<Void, Never>()
  let nextPage = PassthroughSubject<Void, Never>()
  let searchText = CurrentValueSubject<String?, Never>(nil)
}

private func assertMoviesViewModel(
  file: StaticString = #file,
  line: UInt = #line,
  movieRepo: MovieRepo,
  metadata: MetaData,
  commands: @escaping (MoviesViewModelTestsInput) -> Void,
  assertions: [MoviesEvent]
) {
  let metadata = CurrentValueSubject<MetaData, Never>(metadata).eraseToAnyPublisher()
  let viewModel = MoviesViewModel.default(movieRepo: movieRepo, metaData: metadata)

  let input = MoviesViewModelTestsInput()
  let output = viewModel.transform(
    .init(
      refresh: input.refresh.eraseToAnyPublisher(),
      nextPage: input.nextPage.eraseToAnyPublisher(),
      searchText: input.searchText.eraseToAnyPublisher()
    )
  )

  let publisher = Publishers.Merge3(
    output.values.map(MoviesEvent.values)
      .merge(with: output.filteredValues.map(MoviesEvent.filteredValues)),
    output.error.map(MoviesEvent.error),
    output.isRefreshing.map(MoviesEvent.isRefreshing)
  )

  assertPublisherEvents(
    file: file,
    line: line,
    publisher: publisher.eraseToAnyPublisher(),
    trigger: { commands(input) },
    assertions: assertions
  )
}
