import AppFramework
import Combine
import TestSupport
import TheMovieDatabaseApi
import XCTest

final class MoviesViewModelTests: XCTestCase {
  var viewModel: MoviesViewModel!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    viewModel = .init()
    cancellables = .init()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    cancellables = nil
  }

  func testMoviesViewModel_WithSuccessfulRequests() throws {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    let discoverMovieResponse = DiscoverMovieResponse(
      page: 1,
      totalResults: 2,
      totalPages: 3,
      results: [
        .init(id: 1, title: "", overview: "", posterPath: "", releaseDate: ""),
      ]
    )
    let data: Data = try! encoder.encode(discoverMovieResponse)
    let response = HTTPURLResponse(url: TestConstants.exampleUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let client = TMDClient.mock(with: data, andResponse: response)
    withEnvironment(client: client) {
      let refresh = PassthroughSubject<Void, Never>()
      let nextPage = PassthroughSubject<Void, Never>()
      let bindings = self.viewModel.setupBindings(
        refresh: refresh.eraseToAnyPublisher(),
        nextPage: nextPage.eraseToAnyPublisher()
      )

      let valuesExpectation = self.expectation(description: "values")
      let refreshExpectation = self.expectation(description: "refresh")

      bindings
        .values
        .collect(3)
        .sink(receiveValue: { values in
          XCTAssertEqual(
            values.map(\.count),
            [1, 2, 1]
          )
          valuesExpectation.fulfill()
        })
        .store(in: &self.cancellables)

      bindings
        .error
        .sink(receiveValue: { error in
          XCTFail(error.localizedDescription)
        })
        .store(in: &self.cancellables)

      bindings
        .isRefreshing
        .collect(5)
        .sink(receiveValue: { value in
          XCTAssertEqual(value, [
            false,
            true,
            false,
            true,
            false,
          ])
          refreshExpectation.fulfill()
        })
        .store(in: &self.cancellables)

      refresh.send(())
      nextPage.send(())
      refresh.send(())

      self.waitForExpectations(timeout: 1.0, handler: nil)
    }
  }
}
